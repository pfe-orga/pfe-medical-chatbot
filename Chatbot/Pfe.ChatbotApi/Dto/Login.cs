﻿namespace Pfe.ChatbotApi.Dto
{
    public class Login
    {
        public String UserName { get; set; }
        public String Password { get; set; }
        public string Provider { get; internal set; }
    }
}
