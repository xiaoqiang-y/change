using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using WebAppAPI.Models;
using Microsoft.Extensions.Caching.StackExchangeRedis;
namespace WebAppAPI
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();
            //依赖注入一个数据库上下文
            string connString = Configuration.GetSection("connString")["ChangeDB"];
            services.AddDbContext<ChangeDBContext>(options =>
            {
                options.UseSqlServer(connString);
            });

            //添加跨域
            services.AddCors(options => {
                options.AddPolicy("CorsPolicy", builder => {
                    //声明跨域策略：允许所有域、允许任何请求标头和允许全部HTTP方法
                    builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod();
                });
            });
            services.AddSession(options =>      //添加session服务
            {
                options.IdleTimeout = TimeSpan.FromMinutes(10);//超时时间,分钟
                options.Cookie.HttpOnly = true;//在cookie中设置了HttpOnly属性，那么通过js脚本将无法读取到cookie信息，这样能有效的防止XSS攻击。

                //解释：这是个GDRP条例，让用户自己选择使用用cookie，详见 http://www.zhibin.org/archives/667 或 https://www.cnblogs.com/GuZhenYin/p/9154447.html
                options.Cookie.IsEssential = true;//表示cookie是必须的，否则chrome中拿不到Session值
            });
            services.AddSingleton<IDistributedCache>(//读取配置文件
                ServiceProvider => new RedisCache(new RedisCacheOptions //关联Session，通过Session调Redis
                {
                    Configuration = Configuration.GetSection("RedisDB:Connstring").Value,
                    InstanceName = Configuration.GetSection("RedisDB:Instance").Value,
                })
                );
            //分布式环境中设置相同的会话标识
            services.AddDataProtection(options => {
                options.ApplicationDiscriminator = "lrk.com";
            });

        
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            //添加跨域中间件
            app.UseCors();
            app.UseSession();//添加session中间件
            app.UseEndpoints(endpoints =>
            {
                //将CORS策略应用到所有应用终结点
                endpoints.MapControllers().RequireCors("CorsPolicy");
            });
        }
    }
}
