#include "clipboard.h"
#include <QClipboard>
#include <QApplication>

Clipboard::Clipboard(QObject *parent)
    : QObject(parent)
{
    clipboard = QApplication::clipboard();
}

void Clipboard::clipText(const QString text)
{
    clipboard->setText(text, QClipboard::Clipboard);
    clipboard->setText(text, QClipboard::Selection);
}
