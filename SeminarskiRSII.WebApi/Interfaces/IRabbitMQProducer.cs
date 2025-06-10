namespace SeminarskiRSII.WebApi.Interfaces
{
    public interface IRabbitMQProducer
    {
        public void SendMessage<T>(T message);
    }
}
