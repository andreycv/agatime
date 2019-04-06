#include "api.h"
#include "sqliteapi.h"

Api::Api(QObject *parent) : QObject(parent)
{
  //По-умолчанию сегодня
  day();
}

bool Api::day(QString date)
{
  SQLiteApi api;
  Action act;
  if(date.isEmpty())
    act = api.get(QDate::currentDate());
  else
    act = api.get(QDate::fromString(date, FORMAT_DATE));

  if(act.data.isNull() || (api.lastError() != Error::NoError))
  {
    //есть ошибка - что то предпринимаем
    m_start = QTime();
    m_finish = QTime();
    m_startDinner = QTime();
    m_finishDinner = QTime();
    m_date = QDate();
    m_message.clear();
    return false;
  }

  m_start = act.start;
  m_finish = act.finish;
  m_startDinner = act.startDinner;
  m_finishDinner = act.finishDinner;
  m_date = act.data;
  m_message = act.comment;
  return true;
}

QString Api::getStart() const
{
  return m_start.toString(FORMAT_TIME);
}

QString Api::getFinish() const
{
  return m_finish.toString(FORMAT_TIME);
}

QString Api::getStartDinner() const
{
  return m_startDinner.toString(FORMAT_TIME);
}

QString Api::getFinishDinner() const
{
  return m_finishDinner.toString(FORMAT_TIME);
}

QString Api::getDate() const
{
  return m_date.toString(FORMAT_DATE);
}

QString Api::getMessage() const
{
  return m_message;
}

bool Api::setStart()
{
  Action act;
  act.data = QDate::currentDate();
  act.start = QTime::currentTime();
  SQLiteApi api;
  if(api.add(act)) {
    m_start = act.start;
    m_date = act.data;
    return true;
  }
  return false;
}

bool Api::setFinish()
{
  SQLiteApi api;
  Action act;
  act.data = QDate::currentDate();
  act.finish = QTime::currentTime();
  if(api.update(act)) {
    m_finish = act.finish;
    return true;
  }
  return false;
}

bool Api::setStartDinner()
{
  SQLiteApi api;
  Action act;
  act.data = QDate::currentDate();
  act.startDinner = QTime::currentTime();
  if(api.update(act)) {
    m_startDinner = act.startDinner;
    return true;
  }
  return false;
}

bool Api::setFinishDinner()
{
  SQLiteApi api;
  Action act;
  act.data = QDate::currentDate();
  act.finishDinner = QTime::currentTime();
  if(api.update(act)) {
    m_finishDinner = act.finishDinner;
    return true;
  }
  return false;
}

bool Api::setMessage(const QString& message) const
{
  SQLiteApi api;
  Action act;
  act.data = QDate::currentDate();
  act.comment = message;
  return api.update(act);
}

bool Api::del(QString date)
{
  QDate data(QDate::fromString(date, FORMAT_DATE));
  if(!data.isValid())
    return false;
  SQLiteApi api;
  return api.del(data);
}

bool Api::update(QString date, QString str, int num)
{
  return true;
  Action act;
  act.data = QDate::fromString(date, FORMAT_DATE);
  switch(num) {
  case Enum::Start :
    act.start = QTime::fromString(str, FORMAT_TIME);
    break;
  case Enum::Finish :
    act.finish = QTime::fromString(str, FORMAT_TIME);
    break;
  case Enum::StartDinner :
    act.startDinner = QTime::fromString(str, FORMAT_TIME);
    break;
  case Enum::FinishDinner :
    act.finishDinner = QTime::fromString(str, FORMAT_TIME);
    break;
  case Enum::Comment :
    act.comment = str;
    break;
  default :
    return false;
  }
  SQLiteApi api;
  return api.update(act);
}
