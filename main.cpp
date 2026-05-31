#include <QGuiApplication>
#include <QIcon>
#include <QPainter>
#include <QPixmap>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "./Interface/Interface.h"

// 生成多尺寸图标，适应不同 DPI 场景
QIcon createSquareIconMultiSize(const QString& iconPath)
{
    QIcon icon;
    QList<int> sizes = {16, 32, 48, 64, 128}; // 常见图标尺寸

    for (int size : sizes)
    {
        QPixmap original(iconPath);
        if (original.isNull())
        {
            qWarning() << "Failed to load icon:" << iconPath;
            return QIcon();
        }

        QPixmap square(size, size);
        square.fill(Qt::transparent);

        QPainter painter(&square);
        QPixmap scaled = original.scaled(size, size,
                                         Qt::KeepAspectRatio,
                                         Qt::SmoothTransformation);
        int x = (size - scaled.width()) / 2;
        int y = (size - scaled.height()) / 2;
        painter.drawPixmap(x, y, scaled);

        icon.addPixmap(square);
    }

    return icon;
}

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []()
        { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // 使用
    app.setWindowIcon(createSquareIconMultiSize(":/Images/Home/vehicle.png"));

    engine.rootContext()->setContextProperty("ui", INTERFACE);
    engine.loadFromModule("CID", "Main");

    return QCoreApplication::exec();
}
