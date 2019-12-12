#ifndef CLIPBOARD_H
#define CLIPBOARD_H

#include <QObject>
class QClipboard;

class Clipboard : public QObject
{
    Q_OBJECT
public:
    Clipboard(QObject *parent = nullptr);

    Q_INVOKABLE void clipText(const QString text);

private:
    QClipboard *clipboard;
};

#endif // CLIPBOARD_H
