#ifndef SQLITEAPI_H
#define SQLITEAPI_H

#ifdef _WIN32
  // C:\Users\User\AppData\Local\VirtualStore
  #define DB_PATH "C:/db.sql"
#else
  // Android 9
  #define DB_PATH "/mnt/sdcard/AgaTime/db.sql"
#endif

#define FORMAT_DATE "yyyy-MM-dd"
#define FORMAT_TIME "hh:mm:ss"

#include <QObject>
#include <QtSql/QSql>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlDatabase>

#include <QDateTime>

struct Action
{
  QDate data;
  QTime start;
  QTime finish;
  QTime startDinner;
  QTime finishDinner;
  QString comment;
  Action(const QDate _data = QDate(),
         const QString _comment = QString(),
         const QTime _start = QTime(),
         const QTime _finish = QTime(),
         const QTime _startDinner = QTime(),
         const QTime _finishDinner = QTime());
};

enum Error
{
  NoError,
  Open,
  Create,
  Add,
  Del,
  Get
};

class SQLiteApi : public QObject
{
  Q_OBJECT
public:
  explicit SQLiteApi(QObject *parent = nullptr);
  ~SQLiteApi();

  bool add(const Action& action);
  bool del(const QDate& date);
  Action get(const QDate& date);
  bool update(const Action& action);

  Error lastError() const;
signals:

public slots:

private:
  QSqlDatabase m_db;
  Error m_lastError;

  bool openDB();
  bool createTables();

};

#endif // SQLITEAPI_H
