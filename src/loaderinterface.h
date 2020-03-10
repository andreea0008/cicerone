#ifndef LOADERINTERFACE_H
#define LOADERINTERFACE_H

#include <QObject>

class LoaderInterface : public QObject
{
    Q_OBJECT
public:
    explicit LoaderInterface(QObject *parent = nullptr);

    virtual void load()=0;
    virtual void save()=0;

signals:

public slots:
};

#endif // LOADERINTERFACE_H
