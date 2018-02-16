﻿
namespace Sigcomt.Common
{
    public class JsonResponse
    {
        public string Title { get; set; }
        public string Message { get; set; }
        public bool Success { get; set; }
        public bool Warning { get; set; }
        public object Data { get; set; }
    }
}
