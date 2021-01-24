#ifndef CAMERAFILTER_H
#define CAMERAFILTER_H

#include "videorenderer.h"

#include <QtMultimedia/QVideoFilterRunnable>

#include <QCamera>

class CameraFilter : public QAbstractVideoFilter
{
    Q_OBJECT

public:
    CameraFilter(QObject *parent = NULL);
    ~CameraFilter();

    Q_INVOKABLE void setCamera(QObject *camera);
    Q_INVOKABLE void setVideoRenderer(VideoRenderer *renderer);
    Q_INVOKABLE void setVideoSurface(QAbstractVideoSurface *surface);

    void renderFrame(QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat);

    // QAbstractVideoFilter interface
public:
    QVideoFilterRunnable *createFilterRunnable();

public:
    static void registerQmlType();

private:
    QCamera *_camera;
    VideoRenderer *_renderer;
};


class CameraFilterRunable : public QVideoFilterRunnable
{
public:
    CameraFilterRunable(CameraFilter *filter);
    ~CameraFilterRunable();

    // QVideoFilterRunnable interface
public:
    QVideoFrame run(QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags);

private:
    CameraFilter *_filter;
};


#endif // CAMERAFILTER_H
