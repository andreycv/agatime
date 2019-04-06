#include "sqliteapi.h"

#include <QFile>
#include <QDebug>

SQLiteApi::SQLiteApi(QObject *parent)
  : QObject(parent)
   ,m_lastError(Error::NoError)
{
//  qDebug() << Q_FUNC_INFO;
  if(QFile(DB_PATH).exists())
  {
    openDB();
  }
  else
  {
    if(!(openDB() && createTables()))
      m_lastError = Error::Open;
  }
}

SQLiteApi::~SQLiteApi()
{
  m_db.close();
}

bool SQLiteApi::add(const Action& action)
{
  QSqlQuery query;
  QString q = QString("INSERT INTO AgaTime"
              "(DATA, START, FINISH, StartDinner, FinishDinner, Comment) "
              "VALUES ('%1', '%2', '%3', '%4', '%5', '%6')")
      .arg(action.data.toString(FORMAT_DATE))
      .arg(action.start.toString(FORMAT_TIME))
      .arg(action.finish.toString(FORMAT_TIME))
      .arg(action.startDinner.toString(FORMAT_TIME))
      .arg(action.finishDinner.toString(FORMAT_TIME))
      .arg(action.comment);

  return query.exec(q);
}

bool SQLiteApi::del(const QDate &date)
{
  QSqlQuery query;
  QString q = QString("DELETE FROM AgaTime WHERE DATA= '%1'").arg(date.toString(FORMAT_DATE));
  return query.exec(q);
}

Action SQLiteApi::get(const QDate &date)
{
  QSqlQuery query;
  QString q = QString("SELECT DATA, START, FINISH, StartDinner, FinishDinner, Comment FROM AgaTime WHERE DATA= '%1'").arg(date.toString(FORMAT_DATE));
  if(!query.exec(q))
  {
    m_lastError = Error::Get;
    return Action();
  }
  if(query.next())
  {
    return
      Action(
          QDate::fromString(query.value(0).toString(), FORMAT_DATE),
          query.value(5).toString(),
          QTime::fromString(query.value(1).toString(), FORMAT_TIME),
          QTime::fromString(query.value(2).toString(), FORMAT_TIME),
          QTime::fromString(query.value(3).toString(), FORMAT_TIME),
          QTime::fromString(query.value(4).toString(), FORMAT_TIME));
  }

  return Action();
}

bool SQLiteApi::update(const Action& action)
{
  QSqlQuery query;
  bool res = true;
  QString q;
  if(!action.start.isNull()) {
    q = QString("UPDATE AgaTime SET START = '%2' WHERE DATA= '%1'")
      .arg(action.data.toString(FORMAT_DATE))
      .arg(action.start.toString(FORMAT_TIME));
    res = query.exec(q) && res;
  }
  if(!action.finish.isNull()) {
    q = QString("UPDATE AgaTime SET FINISH = '%2' WHERE DATA= '%1'")
      .arg(action.data.toString(FORMAT_DATE))
      .arg(action.finish.toString(FORMAT_TIME));
    res = query.exec(q) && res;
  }
  if(!action.startDinner.isNull()) {
    q = QString("UPDATE AgaTime SET StartDinner = '%2' WHERE DATA= '%1'")
      .arg(action.data.toString(FORMAT_DATE))
      .arg(action.startDinner.toString(FORMAT_TIME));
    res = query.exec(q) && res;
  }
  if(!action.finishDinner.isNull()) {
    q = QString("UPDATE AgaTime SET FinishDinner = '%2' WHERE DATA= '%1'")
      .arg(action.data.toString(FORMAT_DATE))
      .arg(action.finishDinner.toString(FORMAT_TIME));
    res = query.exec(q) && res;
  }
  if(!action.comment.isEmpty()) {
    q = QString("UPDATE AgaTime SET Comment = '%2' WHERE DATA= '%1'")
      .arg(action.data.toString(FORMAT_DATE))
      .arg(action.comment);
    res = query.exec(q) && res;
  }
  return res;
}

Error SQLiteApi::lastError() const
{
  return m_lastError;
}

bool SQLiteApi::openDB()
{
//  qDebug() << Q_FUNC_INFO;
  m_db = QSqlDatabase::addDatabase("QSQLITE");
  m_db.setHostName("db.sql");
  m_db.setDatabaseName(DB_PATH);
  return m_db.open();
}

bool SQLiteApi::createTables()
{
//  qDebug() << Q_FUNC_INFO;
  QSqlQuery query;
  return
      query.exec("CREATE TABLE AgaTime"
                 "(DATA DATE PRIMARY KEY,"
                 "START TIME,"
                 "FINISH TIME,"
                 "StartDinner TIME,"
                 "FinishDinner TIME,"
                 "Comment VARCHAR(255))");
}

Action::Action(const QDate _data,
               const QString _comment,
               const QTime _start,
               const QTime _finish,
               const QTime _startDinner,
               const QTime _finishDinner)
  :data(_data)
  ,start(_start)
  ,finish(_finish)
  ,startDinner(_startDinner)
  ,finishDinner(_finishDinner)
  ,comment(_comment)
{}
