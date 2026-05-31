#include "Interface.h"

Q_GLOBAL_STATIC(Interface, interface)

Interface::Interface(QObject* parent)
    : QObject{parent}
{
    pageIndex = PAGE_HOME;
}

Interface* Interface::instance()
{
    return interface();
}

// ==================== 页面导航 ====================

int Interface::getPAGE_CONTROL() { return PAGE_CONTROL; }
int Interface::getPAGE_SETTINGS() { return PAGE_SETTINGS; }
int Interface::getPAGE_APP() { return PAGE_APP; }
int Interface::getPAGE_AC() { return PAGE_AC; }
int Interface::getPAGE_HOME() { return PAGE_HOME; }
int Interface::getPAGE_MAIN() { return PAGE_MAIN; }

int Interface::getPreviousPageIndex() const { return previousPageIndex; }
void Interface::setPreviousPageIndex(int newPreviousPageIndex)
{
    if (previousPageIndex == newPreviousPageIndex) return;
    previousPageIndex = newPreviousPageIndex;
    emit previousPageIndexChanged();
}

int Interface::getPageIndex() const { return pageIndex; }
void Interface::setPageIndex(int newPageIndex)
{
    if (pageIndex == newPageIndex) return;
    previousPageIndex = pageIndex;
    pageIndex = newPageIndex;
    emit pageIndexChanged();
    emit previousPageIndexChanged();
}

// ==================== 空调 (AC) ====================

double Interface::getAcLeftTemp() const { return m_acLeftTemp; }
void Interface::setAcLeftTemp(double temp)
{
    if (qFuzzyCompare(m_acLeftTemp, temp)) return;
    m_acLeftTemp = temp;
    emit acLeftTempChanged();
}

double Interface::getAcRightTemp() const { return m_acRightTemp; }
void Interface::setAcRightTemp(double temp)
{
    if (qFuzzyCompare(m_acRightTemp, temp)) return;
    m_acRightTemp = temp;
    emit acRightTempChanged();
}

int Interface::getAcFanSpeed() const { return m_acFanSpeed; }
void Interface::setAcFanSpeed(int speed)
{
    if (m_acFanSpeed == speed) return;
    m_acFanSpeed = speed;
    emit acFanSpeedChanged();
}

int Interface::getAcMode() const { return m_acMode; }
void Interface::setAcMode(int mode)
{
    if (m_acMode == mode) return;
    m_acMode = mode;
    emit acModeChanged();
}

bool Interface::getAcInnerCirculation() const { return m_acInnerCirculation; }
void Interface::setAcInnerCirculation(bool on)
{
    if (m_acInnerCirculation == on) return;
    m_acInnerCirculation = on;
    emit acInnerCirculationChanged();
}

bool Interface::getAcDefrost() const { return m_acDefrost; }
void Interface::setAcDefrost(bool on)
{
    if (m_acDefrost == on) return;
    m_acDefrost = on;
    emit acDefrostChanged();
}

bool Interface::getAcOn() const { return m_acOn; }
void Interface::setAcOn(bool on)
{
    if (m_acOn == on) return;
    m_acOn = on;
    emit acOnChanged();
}

// ==================== 媒体播放 (Media) ====================

bool Interface::getMediaPlaying() const { return m_mediaPlaying; }
void Interface::setMediaPlaying(bool playing)
{
    if (m_mediaPlaying == playing) return;
    m_mediaPlaying = playing;
    emit mediaPlayingChanged();
}

QString Interface::getMediaTitle() const { return m_mediaTitle; }
void Interface::setMediaTitle(const QString& title)
{
    if (m_mediaTitle == title) return;
    m_mediaTitle = title;
    emit mediaTitleChanged();
}

QString Interface::getMediaArtist() const { return m_mediaArtist; }
void Interface::setMediaArtist(const QString& artist)
{
    if (m_mediaArtist == artist) return;
    m_mediaArtist = artist;
    emit mediaArtistChanged();
}

QString Interface::getMediaAlbumArt() const { return m_mediaAlbumArt; }
void Interface::setMediaAlbumArt(const QString& art)
{
    if (m_mediaAlbumArt == art) return;
    m_mediaAlbumArt = art;
    emit mediaAlbumArtChanged();
}

int Interface::getMediaSource() const { return m_mediaSource; }
void Interface::setMediaSource(int source)
{
    if (m_mediaSource == source) return;
    m_mediaSource = source;
    emit mediaSourceChanged();
}

// ==================== 车辆状态 (Vehicle) ====================

double Interface::getVehicleMileage() const { return m_vehicleMileage; }
void Interface::setVehicleMileage(double mileage)
{
    if (qFuzzyCompare(m_vehicleMileage, mileage)) return;
    m_vehicleMileage = mileage;
    emit vehicleMileageChanged();
}

int Interface::getVehicleRange() const { return m_vehicleRange; }
void Interface::setVehicleRange(int range)
{
    if (m_vehicleRange == range) return;
    m_vehicleRange = range;
    emit vehicleRangeChanged();
}

int Interface::getVehicleGear() const { return m_vehicleGear; }
void Interface::setVehicleGear(int gear)
{
    if (m_vehicleGear == gear) return;
    m_vehicleGear = gear;
    emit vehicleGearChanged();
}

int Interface::getVehicleCondition() const { return m_vehicleCondition; }
void Interface::setVehicleCondition(int condition)
{
    if (m_vehicleCondition == condition) return;
    m_vehicleCondition = condition;
    emit vehicleConditionChanged();
}

int Interface::getVehicleSpeed() const { return m_vehicleSpeed; }
void Interface::setVehicleSpeed(int speed)
{
    if (m_vehicleSpeed == speed) return;
    m_vehicleSpeed = speed;
    emit vehicleSpeedChanged();
}

// ==================== 控制中心 (ControlCenter) ====================

bool Interface::getBluetoothOn() const { return m_bluetoothOn; }
void Interface::setBluetoothOn(bool on)
{
    if (m_bluetoothOn == on) return;
    m_bluetoothOn = on;
    emit bluetoothOnChanged();
}

bool Interface::getWlanOn() const { return m_wlanOn; }
void Interface::setWlanOn(bool on)
{
    if (m_wlanOn == on) return;
    m_wlanOn = on;
    emit wlanOnChanged();
}

bool Interface::getHudOn() const { return m_hudOn; }
void Interface::setHudOn(bool on)
{
    if (m_hudOn == on) return;
    m_hudOn = on;
    emit hudOnChanged();
}

bool Interface::getEspOn() const { return m_espOn; }
void Interface::setEspOn(bool on)
{
    if (m_espOn == on) return;
    m_espOn = on;
    emit espOnChanged();
}

bool Interface::getDynamicSuspension() const { return m_dynamicSuspension; }
void Interface::setDynamicSuspension(bool on)
{
    if (m_dynamicSuspension == on) return;
    m_dynamicSuspension = on;
    emit dynamicSuspensionChanged();
}

bool Interface::getVentilation() const { return m_ventilation; }
void Interface::setVentilation(bool on)
{
    if (m_ventilation == on) return;
    m_ventilation = on;
    emit ventilationChanged();
}

bool Interface::getAutoRotation() const { return m_autoRotation; }
void Interface::setAutoRotation(bool on)
{
    if (m_autoRotation == on) return;
    m_autoRotation = on;
    emit autoRotationChanged();
}

bool Interface::getThemeDark() const { return m_themeDark; }
void Interface::setThemeDark(bool on)
{
    if (m_themeDark == on) return;
    m_themeDark = on;
    emit themeDarkChanged();
}

bool Interface::getMute() const { return m_mute; }
void Interface::setMute(bool on)
{
    if (m_mute == on) return;
    m_mute = on;
    emit muteChanged();
}

int Interface::getBrightness() const { return m_brightness; }
void Interface::setBrightness(int value)
{
    if (m_brightness == value) return;
    m_brightness = value;
    emit brightnessChanged();
}

int Interface::getVolume() const { return m_volume; }
void Interface::setVolume(int value)
{
    if (m_volume == value) return;
    m_volume = value;
    emit volumeChanged();
}

// ==================== 状态栏 (StatusBar) ====================

int Interface::getSignalStrength() const { return m_signalStrength; }
void Interface::setSignalStrength(int strength)
{
    if (m_signalStrength == strength) return;
    m_signalStrength = strength;
    emit signalStrengthChanged();
}

bool Interface::getBtConnected() const { return m_btConnected; }
void Interface::setBtConnected(bool connected)
{
    if (m_btConnected == connected) return;
    m_btConnected = connected;
    emit btConnectedChanged();
}

bool Interface::getGpsOn() const { return m_gpsOn; }
void Interface::setGpsOn(bool on)
{
    if (m_gpsOn == on) return;
    m_gpsOn = on;
    emit gpsOnChanged();
}

// ==================== 导航 (Navigation) ====================

QString Interface::getNavDestination() const { return m_navDestination; }
void Interface::setNavDestination(const QString& dest)
{
    if (m_navDestination == dest) return;
    m_navDestination = dest;
    emit navDestinationChanged();
}

double Interface::getNavDistance() const { return m_navDistance; }
void Interface::setNavDistance(double distance)
{
    if (qFuzzyCompare(m_navDistance, distance)) return;
    m_navDistance = distance;
    emit navDistanceChanged();
}

QString Interface::getNavEta() const { return m_navEta; }
void Interface::setNavEta(const QString& eta)
{
    if (m_navEta == eta) return;
    m_navEta = eta;
    emit navEtaChanged();
}

bool Interface::getNavActive() const { return m_navActive; }
void Interface::setNavActive(bool active)
{
    if (m_navActive == active) return;
    m_navActive = active;
    emit navActiveChanged();
}

// ==================== 天气 (Weather) ====================

int Interface::getWeatherTemp() const { return m_weatherTemp; }
void Interface::setWeatherTemp(int temp)
{
    if (m_weatherTemp == temp) return;
    m_weatherTemp = temp;
    emit weatherTempChanged();
}

QString Interface::getWeatherIcon() const { return m_weatherIcon; }
void Interface::setWeatherIcon(const QString& icon)
{
    if (m_weatherIcon == icon) return;
    m_weatherIcon = icon;
    emit weatherIconChanged();
}

QString Interface::getWeatherDesc() const { return m_weatherDesc; }
void Interface::setWeatherDesc(const QString& desc)
{
    if (m_weatherDesc == desc) return;
    m_weatherDesc = desc;
    emit weatherDescChanged();
}
