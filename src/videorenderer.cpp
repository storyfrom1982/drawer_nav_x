#include "videorenderer.h"

#include <QVideoSurfaceFormat>
#include <QtQml>

VideoRenderer::VideoRenderer(QObject *parent) : QObject(parent), _surface(NULL)
{

}

VideoRenderer::~VideoRenderer()
{
    if(_surface && _surface->isActive())
        _surface->stop();
}

void VideoRenderer::renderFrame(QVideoFrame *videoFrame, const QVideoSurfaceFormat &surfaceFormat)
{
    if(!_surface->isActive()){
        qDebug("VideoRenderer::renderFrame %d\n", surfaceFormat.pixelFormat());
        QVideoSurfaceFormat format = QVideoSurfaceFormat(surfaceFormat.frameSize(), surfaceFormat.pixelFormat());
        _surface->start(format);
    }
    _surface->present(*videoFrame);
}

void VideoRenderer::registerQmlType()
{
    qmlRegisterType<VideoRenderer>("VideoLib", 1, 0, "VideoRenderer");
}

QAbstractVideoSurface *VideoRenderer::getVideoSurface() const
{
    qDebug("VideoRenderer::getVideoSurface\n");
    return _surface;
}

void VideoRenderer::setVideoSurface(QAbstractVideoSurface *s)
{
    qDebug("VideoRenderer::setVideoSurface\n");
    if(_surface && _surface->isActive())
        _surface->stop();
    _surface = s;
}
