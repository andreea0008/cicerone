#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>

class Settings : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool isSendData READ isSendData WRITE setIsSendData NOTIFY isSendDataChanged)
    bool m_isSendData;

public:
    explicit Settings(QObject *parent = nullptr);
    ~Settings();
    bool isSendData() const;

signals:
    void isSendDataChanged(bool isSendData);

public slots:
    Q_INVOKABLE void setIsSendData(bool isSendData);
    Q_INVOKABLE void saveSettings();
    Q_INVOKABLE void loadSettings();
};

#endif // SETTINGS_H
