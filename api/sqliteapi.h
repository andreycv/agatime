#ifndef SQLITEAPI_H
#define SQLITEAPI_H

#include <QtSql/QSql>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlDatabase>

#include <QDateTime>

#ifdef _WIN32
  // Начиная с Win8 C:\Users\User\AppData\Local\VirtualStore
  #define DB_PATH "C:/db.sql"
#else
  // Android 9
  #define DB_PATH "/mnt/sdcard/AgaTime/db.sql"
#endif

#define FORMAT_DATE "yyyy-MM-dd"
#define FORMAT_TIME "hh:mm:ss"

/*!
 * \brief Структура описывающая день
 */
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

/*!
 * \brief Типы Error при взаимодействии с бд
 */
enum Error
{
  NoError,
  Open,
  Create,
  Add,
  Del,
  Get
};
/*!
 * \brief Адаптированное API над SQLite
 */
class SQLiteApi
{
public:
  /*!
  * \brief Инициализировать взаимодейтвие с БД
  * \details Создать бд, создать таблицу, если отсутствует.
  */
  SQLiteApi();
  ~SQLiteApi();

  /*!
  * \brief добавить инфу о новом для бд дне
  * \details использовать только для новой записи в бд,
  * иначе вернет false и обновление не пройдет
  * \param action инфа о дне
  * \return true - успешно добавлено, false - что то пошло не так
  */
  bool add(const Action& action);
  bool del(const QDate& date);
  Action get(const QDate& date);
  bool update(const Action& action);

  Error lastError() const;

private:
  QSqlDatabase m_db;
  Error m_lastError;

  bool openDB();
  bool createTables();

};

#endif // SQLITEAPI_H
