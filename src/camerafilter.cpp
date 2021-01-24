#include "camerafilter.h"

#include <QCamera>
#include <QtQml>

CameraFilter::CameraFilter(QObject *parent)
    : QAbstractVideoFilter(parent)
{
    _renderer = NULL;
}

CameraFilter::~CameraFilter()
{

}

void CameraFilter::setCamera(QObject *camera)
{
    qDebug("CameraFilter::setCamera\n");
//    _camera = qvariant_cast<QCamera*>(camera->property("mediaObject"));
//    _camera->setCaptureMode(QCamera::CaptureMode::CaptureVideo);
//    QCameraViewfinderSettings setting = _camera->viewfinderSettings();
//    setting.setPixelFormat(QVideoFrame::Format_YUV420P);
//    _camera->setViewfinderSettings(setting);
//    _camera->start();
//    _camera->setViewfinder(_surface);
}

void CameraFilter::setVideoRenderer(VideoRenderer *renderer)
{
    qDebug("CameraFilter::setVideoRenderer\n");
    _renderer = renderer;
}

void CameraFilter::setVideoSurface(QAbstractVideoSurface *surface)
{
    qDebug("CameraFilter::setVideoSurface %d\n", surface->surfaceFormat().pixelFormat());
    QList<QVideoFrame::PixelFormat> fmts = surface->supportedPixelFormats();
    for (QVideoFrame::PixelFormat fmt: fmts){
        qDebug("CameraFilter::setVideoSurface %d\n", fmt);
    }
}

void CameraFilter::renderFrame(QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat)
{
    if (_renderer){
        _renderer->renderFrame(input, surfaceFormat);
    }
}

QVideoFilterRunnable *CameraFilter::createFilterRunnable()
{
    return new CameraFilterRunable( this );
}

void CameraFilter::registerQmlType()
{
    qmlRegisterType< CameraFilter >("VideoLib", 1, 0, "CameraFilter" );
}

CameraFilterRunable::CameraFilterRunable(CameraFilter *filter)
    : _filter(filter)
{

}

CameraFilterRunable::~CameraFilterRunable()
{

}

QVideoFrame CameraFilterRunable::run(QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, QVideoFilterRunnable::RunFlags flags)
{
    _filter->renderFrame(input, surfaceFormat);
    return *input;
}
