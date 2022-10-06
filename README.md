# Mac-OS-Dynamic-Walpapers-Ubuntu
A repository containing OS X dynamic walpapers for Ubuntu users with insctructions and scripts

## Available wallpapers:
### Mojave Dynamic

### BigSur Marketing Dynamic

### BigSur Dynamic

## How to install dynamic wallpapers from this repo on Ubuntu 
1. Copy the desired wallpaper folder into `~/Pictures/Wallpapers`
2. Run `./set-wallpaper.sh` script

## How to create a Ubuntu dynamic wallpaper from OSX wallpapers

OS X Dyanmic wallpapers are stored under `.heif` file format.
This format is mostly like a container, it can contains multiple images in one file.

As you may know, ubuntu cannot handle `.heif` file format as walpapers.

To use OSX wallpapers under Ubuntu, we need some intermediate steps:
### 1. Get `.heif` Dyanmic Wallpapers
Either by looking for some on Internet, or directly in OSX under: `/Library/Desktop Pictures`
### 2. Extract all images from `.heif` and convert to `.jpg` format

To do so, we will need to install a package called **libheif-examples**
```bash
# Install libheif-examples which contains heif-convert tool
sudo apt install libheif-examples

# Extract your '.heic / heif' file
# heif-convert SourceFile.heic Dest_file.jpg
heif-convert BigSurMarketting.heic bigsur_marketing.jpg
```
Multiple images have been extracted.

```
bigsur_marketing-1.jpg
bigsur_marketing-2.jpg
...
```

### 3. Create a XML file describing the slideshow

We will now create a XML file describing the slideshow for those images.
In this example, i've use the Big Sur Marketing dynamic wallpaper containing two states:

<img src='./example.gif' alt='example' height='200px'/>

Here is the XML we will use to describe our slideshow:
```xml
<background>
  <starttime>
    <year>2022</year>
    <month>10</month>
    <day>06</day>
    <hour>0</hour>
    <minute>00</minute>
    <second>00</second>
  </starttime>
  <!-- 00:00 -->
  <static>
    <duration>28795.0</duration>
    <file>/home/nico/Pictures/Wallpapers/bigsur-marketing/bigsur-marketing-2.jpg</file>
  </static>
  <transition type="overlay">
    <duration>5.0</duration>
    <from>/home/nico/Pictures/Wallpapers/bigsur-marketing/bigsur-marketing-2.jpg</from>
    <to>/home/nico/Pictures/Wallpapers/bigsur-marketing/bigsur-marketing-1.jpg</to>
  </transition>
  <!-- 08:00 -->
  <static>
    <duration>43195.0</duration>
    <file>/home/nico/Pictures/Wallpapers/bigsur-marketing/igsur-marketing-1.jpg</file>
  </static>
  <transition type="overlay">
    <duration>5.0</duration>
    <from>/home/nico/Pictures/Wallpapers/bigsur-marketing/igsur-marketing-1.jpg</from>
    <to>/home/nico/Pictures/Wallpapers/bigsur-marketing/igsur-marketing-2.jpg</to>
  </transition>
  <!-- 20:00 -->
</background>
```
This XML describes the following scheme:
1. Starting at 00:00, we want the dark wallpaper until 07:59:55 (28795.0 seconds)
2. Then, we have a transition which lasts 5 seconds from dark to light wallpaper
3. Light wallpaper is displayed until 19:59:55 (lasts 43195.0 seconds)
4. We then have a transition from light to dark wallpaper
5. Dark wallpaper will lasts until next day

### 4. Save the file and set as wallpaper
Once you saved your XML file, you can set your wallpaper.
You can't set an XML using default settings menu.

We will use a terminal:
```bash
gsettings set org.gnome.desktop.background picture-uri 'file:///home/nico/Pictures/Wallpapers/bigsur-marketing/bigsur_marketing.xml'
```

Done !