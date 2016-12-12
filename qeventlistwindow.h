#ifndef QEVENTLISTWINDOW_H
#define QEVENTLISTWINDOW_H

#include <QDeclarativeView>

class qEventListWindow : public QDeclarativeView
{
    Q_OBJECT
public:
    explicit qEventListWindow(QDeclarativeView *parent = 0);
    void Init(void);

signals:

public slots:

};

#endif // QEVENTLISTWINDOW_H
