#ifndef VIDEORENDERER_H
#define VIDEORENDERER_H

#include <QAbstractVideoSurface>
#include <QObject>

class VideoRenderer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ getVideoSurface WRITE setVideoSurface)

public:
    explicit VideoRenderer(QObject *parent = nullptr);
    ~VideoRenderer();

    void renderFrame(QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat);

    static void registerQmlType();

private:
    QAbstractVideoSurface* getVideoSurface() const;
    void setVideoSurface(QAbstractVideoSurface* s);

private:
    QAbstractVideoSurface* _surface;

signals:

};

#endif // VIDEORENDERER_H
