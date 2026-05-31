#ifndef INTERFACE_H
#define INTERFACE_H

#include <QObject>
#define INTERFACE (Interface::instance())

class Interface : public QObject
{
    Q_OBJECT
public:
    explicit Interface(QObject* parent = nullptr);

    static Interface* instance();

    // ==================== 页面导航 ====================
    const static int PAGE_MAIN = 0;
    const static int PAGE_HOME = 1;
    const static int PAGE_AC = 2;
    const static int PAGE_APP = 3;
    const static int PAGE_SETTINGS = 4;
    const static int PAGE_CONTROL = 5;

    int pageIndex;
    int previousPageIndex;

    int getPageIndex() const;
    void setPageIndex(int newPageIndex);

    int getPreviousPageIndex() const;
    void setPreviousPageIndex(int newPreviousPageIndex);

    static int getPAGE_MAIN();
    static int getPAGE_HOME();
    static int getPAGE_AC();
    static int getPAGE_APP();
    static int getPAGE_SETTINGS();
    static int getPAGE_CONTROL();

    // ==================== 空调 (AC) ====================
    double getAcLeftTemp() const;
    void setAcLeftTemp(double temp);

    double getAcRightTemp() const;
    void setAcRightTemp(double temp);

    int getAcFanSpeed() const;
    void setAcFanSpeed(int speed);

    int getAcMode() const;
    void setAcMode(int mode);

    bool getAcInnerCirculation() const;
    void setAcInnerCirculation(bool on);

    bool getAcDefrost() const;
    void setAcDefrost(bool on);

    bool getAcOn() const;
    void setAcOn(bool on);

    // ==================== 媒体播放 (Media) ====================
    bool getMediaPlaying() const;
    void setMediaPlaying(bool playing);

    QString getMediaTitle() const;
    void setMediaTitle(const QString& title);

    QString getMediaArtist() const;
    void setMediaArtist(const QString& artist);

    QString getMediaAlbumArt() const;
    void setMediaAlbumArt(const QString& art);

    int getMediaSource() const;
    void setMediaSource(int source);

    // ==================== 车辆状态 (Vehicle) ====================
    double getVehicleMileage() const;
    void setVehicleMileage(double mileage);

    int getVehicleRange() const;
    void setVehicleRange(int range);

    int getVehicleGear() const;
    void setVehicleGear(int gear);

    int getVehicleCondition() const;
    void setVehicleCondition(int condition);

    int getVehicleSpeed() const;
    void setVehicleSpeed(int speed);

    // ==================== 控制中心 (ControlCenter) ====================
    bool getBluetoothOn() const;
    void setBluetoothOn(bool on);

    bool getWlanOn() const;
    void setWlanOn(bool on);

    bool getHudOn() const;
    void setHudOn(bool on);

    bool getEspOn() const;
    void setEspOn(bool on);

    bool getDynamicSuspension() const;
    void setDynamicSuspension(bool on);

    bool getVentilation() const;
    void setVentilation(bool on);

    bool getAutoRotation() const;
    void setAutoRotation(bool on);

    bool getThemeDark() const;
    void setThemeDark(bool on);

    bool getMute() const;
    void setMute(bool on);

    int getBrightness() const;
    void setBrightness(int value);

    int getVolume() const;
    void setVolume(int value);

    // ==================== 状态栏 (StatusBar) ====================
    int getSignalStrength() const;
    void setSignalStrength(int strength);

    bool getBtConnected() const;
    void setBtConnected(bool connected);

    bool getGpsOn() const;
    void setGpsOn(bool on);

    // ==================== 导航 (Navigation) ====================
    QString getNavDestination() const;
    void setNavDestination(const QString& dest);

    double getNavDistance() const;
    void setNavDistance(double distance);

    QString getNavEta() const;
    void setNavEta(const QString& eta);

    bool getNavActive() const;
    void setNavActive(bool active);

    // ==================== 天气 (Weather) ====================
    int getWeatherTemp() const;
    void setWeatherTemp(int temp);

    QString getWeatherIcon() const;
    void setWeatherIcon(const QString& icon);

    QString getWeatherDesc() const;
    void setWeatherDesc(const QString& desc);

signals:
    // 页面导航
    void pageIndexChanged();
    void previousPageIndexChanged();

    // 空调
    void acLeftTempChanged();
    void acRightTempChanged();
    void acFanSpeedChanged();
    void acModeChanged();
    void acInnerCirculationChanged();
    void acDefrostChanged();
    void acOnChanged();

    // 媒体
    void mediaPlayingChanged();
    void mediaTitleChanged();
    void mediaArtistChanged();
    void mediaAlbumArtChanged();
    void mediaSourceChanged();

    // 车辆
    void vehicleMileageChanged();
    void vehicleRangeChanged();
    void vehicleGearChanged();
    void vehicleConditionChanged();
    void vehicleSpeedChanged();

    // 控制中心
    void bluetoothOnChanged();
    void wlanOnChanged();
    void hudOnChanged();
    void espOnChanged();
    void dynamicSuspensionChanged();
    void ventilationChanged();
    void autoRotationChanged();
    void themeDarkChanged();
    void muteChanged();
    void brightnessChanged();
    void volumeChanged();

    // 状态栏
    void signalStrengthChanged();
    void btConnectedChanged();
    void gpsOnChanged();

    // 导航
    void navDestinationChanged();
    void navDistanceChanged();
    void navEtaChanged();
    void navActiveChanged();

    // 天气
    void weatherTempChanged();
    void weatherIconChanged();
    void weatherDescChanged();

private:
    // ==================== 页面导航 ====================
    Q_PROPERTY(int pageIndex READ getPageIndex WRITE setPageIndex NOTIFY pageIndexChanged FINAL)
    Q_PROPERTY(int previousPageIndex READ getPreviousPageIndex WRITE setPreviousPageIndex NOTIFY previousPageIndexChanged FINAL)
    Q_PROPERTY(int PAGE_MAIN READ getPAGE_MAIN CONSTANT FINAL)
    Q_PROPERTY(int PAGE_HOME READ getPAGE_HOME CONSTANT FINAL)
    Q_PROPERTY(int PAGE_AC READ getPAGE_AC CONSTANT FINAL)
    Q_PROPERTY(int PAGE_APP READ getPAGE_APP CONSTANT FINAL)
    Q_PROPERTY(int PAGE_SETTINGS READ getPAGE_SETTINGS CONSTANT FINAL)
    Q_PROPERTY(int PAGE_CONTROL READ getPAGE_CONTROL CONSTANT FINAL)

    // ==================== 空调 ====================
    Q_PROPERTY(double acLeftTemp READ getAcLeftTemp WRITE setAcLeftTemp NOTIFY acLeftTempChanged FINAL)
    Q_PROPERTY(double acRightTemp READ getAcRightTemp WRITE setAcRightTemp NOTIFY acRightTempChanged FINAL)
    Q_PROPERTY(int acFanSpeed READ getAcFanSpeed WRITE setAcFanSpeed NOTIFY acFanSpeedChanged FINAL)
    Q_PROPERTY(int acMode READ getAcMode WRITE setAcMode NOTIFY acModeChanged FINAL)
    Q_PROPERTY(bool acInnerCirculation READ getAcInnerCirculation WRITE setAcInnerCirculation NOTIFY acInnerCirculationChanged FINAL)
    Q_PROPERTY(bool acDefrost READ getAcDefrost WRITE setAcDefrost NOTIFY acDefrostChanged FINAL)
    Q_PROPERTY(bool acOn READ getAcOn WRITE setAcOn NOTIFY acOnChanged FINAL)

    // ==================== 媒体 ====================
    Q_PROPERTY(bool mediaPlaying READ getMediaPlaying WRITE setMediaPlaying NOTIFY mediaPlayingChanged FINAL)
    Q_PROPERTY(QString mediaTitle READ getMediaTitle WRITE setMediaTitle NOTIFY mediaTitleChanged FINAL)
    Q_PROPERTY(QString mediaArtist READ getMediaArtist WRITE setMediaArtist NOTIFY mediaArtistChanged FINAL)
    Q_PROPERTY(QString mediaAlbumArt READ getMediaAlbumArt WRITE setMediaAlbumArt NOTIFY mediaAlbumArtChanged FINAL)
    Q_PROPERTY(int mediaSource READ getMediaSource WRITE setMediaSource NOTIFY mediaSourceChanged FINAL)

    // ==================== 车辆 ====================
    Q_PROPERTY(double vehicleMileage READ getVehicleMileage WRITE setVehicleMileage NOTIFY vehicleMileageChanged FINAL)
    Q_PROPERTY(int vehicleRange READ getVehicleRange WRITE setVehicleRange NOTIFY vehicleRangeChanged FINAL)
    Q_PROPERTY(int vehicleGear READ getVehicleGear WRITE setVehicleGear NOTIFY vehicleGearChanged FINAL)
    Q_PROPERTY(int vehicleCondition READ getVehicleCondition WRITE setVehicleCondition NOTIFY vehicleConditionChanged FINAL)
    Q_PROPERTY(int vehicleSpeed READ getVehicleSpeed WRITE setVehicleSpeed NOTIFY vehicleSpeedChanged FINAL)

    // ==================== 控制中心 ====================
    Q_PROPERTY(bool bluetoothOn READ getBluetoothOn WRITE setBluetoothOn NOTIFY bluetoothOnChanged FINAL)
    Q_PROPERTY(bool wlanOn READ getWlanOn WRITE setWlanOn NOTIFY wlanOnChanged FINAL)
    Q_PROPERTY(bool hudOn READ getHudOn WRITE setHudOn NOTIFY hudOnChanged FINAL)
    Q_PROPERTY(bool espOn READ getEspOn WRITE setEspOn NOTIFY espOnChanged FINAL)
    Q_PROPERTY(bool dynamicSuspension READ getDynamicSuspension WRITE setDynamicSuspension NOTIFY dynamicSuspensionChanged FINAL)
    Q_PROPERTY(bool ventilation READ getVentilation WRITE setVentilation NOTIFY ventilationChanged FINAL)
    Q_PROPERTY(bool autoRotation READ getAutoRotation WRITE setAutoRotation NOTIFY autoRotationChanged FINAL)
    Q_PROPERTY(bool themeDark READ getThemeDark WRITE setThemeDark NOTIFY themeDarkChanged FINAL)
    Q_PROPERTY(bool mute READ getMute WRITE setMute NOTIFY muteChanged FINAL)
    Q_PROPERTY(int brightness READ getBrightness WRITE setBrightness NOTIFY brightnessChanged FINAL)
    Q_PROPERTY(int volume READ getVolume WRITE setVolume NOTIFY volumeChanged FINAL)

    // ==================== 状态栏 ====================
    Q_PROPERTY(int signalStrength READ getSignalStrength WRITE setSignalStrength NOTIFY signalStrengthChanged FINAL)
    Q_PROPERTY(bool btConnected READ getBtConnected WRITE setBtConnected NOTIFY btConnectedChanged FINAL)
    Q_PROPERTY(bool gpsOn READ getGpsOn WRITE setGpsOn NOTIFY gpsOnChanged FINAL)

    // ==================== 导航 ====================
    Q_PROPERTY(QString navDestination READ getNavDestination WRITE setNavDestination NOTIFY navDestinationChanged FINAL)
    Q_PROPERTY(double navDistance READ getNavDistance WRITE setNavDistance NOTIFY navDistanceChanged FINAL)
    Q_PROPERTY(QString navEta READ getNavEta WRITE setNavEta NOTIFY navEtaChanged FINAL)
    Q_PROPERTY(bool navActive READ getNavActive WRITE setNavActive NOTIFY navActiveChanged FINAL)

    // ==================== 天气 ====================
    Q_PROPERTY(int weatherTemp READ getWeatherTemp WRITE setWeatherTemp NOTIFY weatherTempChanged FINAL)
    Q_PROPERTY(QString weatherIcon READ getWeatherIcon WRITE setWeatherIcon NOTIFY weatherIconChanged FINAL)
    Q_PROPERTY(QString weatherDesc READ getWeatherDesc WRITE setWeatherDesc NOTIFY weatherDescChanged FINAL)

    // ==================== 成员变量 ====================
    // 空调
    double m_acLeftTemp = 24.0;
    double m_acRightTemp = 24.0;
    int m_acFanSpeed = 3;
    int m_acMode = 0;
    bool m_acInnerCirculation = false;
    bool m_acDefrost = false;
    bool m_acOn = true;

    // 媒体
    bool m_mediaPlaying = false;
    QString m_mediaTitle;
    QString m_mediaArtist;
    QString m_mediaAlbumArt;
    int m_mediaSource = 0;

    // 车辆
    double m_vehicleMileage = 0;
    int m_vehicleRange = 0;
    int m_vehicleGear = 0; // P
    int m_vehicleCondition = 1;
    int m_vehicleSpeed = 0;

    // 控制中心
    bool m_bluetoothOn = true;
    bool m_wlanOn = true;
    bool m_hudOn = false;
    bool m_espOn = true;
    bool m_dynamicSuspension = false;
    bool m_ventilation = false;
    bool m_autoRotation = false;
    bool m_themeDark = true;
    bool m_mute = false;
    int m_brightness = 80;
    int m_volume = 50;

    // 状态栏
    int m_signalStrength = 3;
    bool m_btConnected = true;
    bool m_gpsOn = true;

    // 导航
    QString m_navDestination;
    double m_navDistance = 0;
    QString m_navEta;
    bool m_navActive = false;

    // 天气
    int m_weatherTemp = 26;
    QString m_weatherIcon;
    QString m_weatherDesc;
};

#endif // INTERFACE_H
