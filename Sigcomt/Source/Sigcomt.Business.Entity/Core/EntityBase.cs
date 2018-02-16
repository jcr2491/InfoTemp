namespace Sigcomt.Business.Entity.Core
{
    public class EntityBase<T>
    {
        public T Id { get; set; }
        public int Estado { get; set; }
        public T Cantidad { get; set; }
    }
}
