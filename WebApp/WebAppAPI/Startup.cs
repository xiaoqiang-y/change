using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using WebAppAPI.Models;

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

            app.UseEndpoints(endpoints =>
            {
                //将CORS策略应用到所有应用终结点
                endpoints.MapControllers().RequireCors("CorsPolicy");
            });
        }
    }
}
