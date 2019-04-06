#ifndef API_H
#define API_H

#include <QObject>
#include <QDate>

/*!
 * \brief Адаптированное API над SQLiteApi(SQLite) для вызовов в QML
 * \details В конструкторе вызывается Api::day() с парам. по-умолчанию
 */
class Api : public QObject
{
  Q_OBJECT
public:

  /*!
  * \brief Тип события
  */
  enum Enum {
    Date = 0,
    Start,
    Finish,
    StartDinner,
    FinishDinner,
    Comment
  };

  explicit Api(QObject *parent = nullptr);

signals:
  void addData(QString str);

public slots:
  /*!
   * \brief Читаем из бд, сохраняем ответ в членах класса
   * \param date интересующая дата, по умолчанию "сегодня"
   */
  bool day(QString date = QString());
  ///< Вернуть строку, начало дня
  QString getStart() const;
  QString getFinish() const;
  QString getStartDinner() const;
  QString getFinishDinner() const;
  QString getDate() const;
  QString getMessage() const;

  bool setStart();
  bool setFinish();
  bool setStartDinner();
  bool setFinishDinner();
  bool setMessage(const QString& message) const;

  bool del(QString date);

  bool update(QString date, QString str, int num);

private:
  QDate m_date;
  QString m_message;
  QTime m_start;
  QTime m_finish;
  QTime m_startDinner;
  QTime m_finishDinner;
};

#endif // API_H
