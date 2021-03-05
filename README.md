# ebu-norm | tp-norm | loudmax-norm | lsp-norm
Scripts to batch normalize files to integrated or true peak targets

Prerequisites: `ebur128`, `sox`

Fully supported file inputs: wav, aiff (or aif), flac, ogg.  
Mp3, opus and wavpack are first converted to wav before normalizing.

### Process
Files are analyzed by `ebur128` with the required gain passed to `SoX`. 
+/− gain is calculated by the target level minus the analyzed integrated or peak value.
In the case of `ebu-norm`, this takes place post-limiting to ensure that the exact integrated value is reached.
Files are written to a sub-folder with suffix added to filename.

N.B. `loudmax-norm` and `lsp-norm` are essentially `ebu-norm` but using Loudmax or LSP limiter respectively as the sole limiter instead of the compand chain. A major benefit is being able to get very close to, or precisely hit, -1 dBTP. It probably goes without saying that `loudmax-norm` and `lsp-norm` require Loudmax and LSP Plugins LADSPA to be installed in `/usr/lib/ladspa`. A user-friendly varible near top of each script is present to allow for the more transparent / less aggressive Loudmax or LSP limiting algorithms. Essentially, if you find you have true peak overage with problematic files, try setting the variables to -1.2 or even -1.5.

### Usage: 
```shell
ebu-norm [-t target_value] infiles
```
where ```-t``` allows for an integrated target other than -23 LUFS.

As of v.0.3, if true peaks rise above -1 dBTP, a `SoX` limiter chain is engaged.

```shell
tp-norm [-t target_value] infiles
```
where ```-t``` allows for an true peak target other than -1 dBTP.

#### Examples

```shell
ebu-norm AudioFolder/*.wav
```
will create an `ebu-norm` sub-folder and create -23 LUFS integrated WAV files (default).

```shell
ebu-norm -t -20 AudioFolder/*.flac 
```
will create an `ebu-norm` sub-folder and create -20 LUFS integrated FLAC files. 

```shell
tp-norm AudioFolder/*.wav
```
will create a `tp-norm` sub-folder and -1 dBTP WAV files (default). 


```shell
tp-norm -t -2 AudioFolder/*.flac
```
will create a `tp-norm` sub-folder and -2 dBTP FLAC files. 

# ebu-scan
Script to batch analyze audio files and print true peak and various loudness values to screen and text file.

Prerequisites: `ebur128`

Fully supported file inputs: wav, aiff (or aif), flac, ogg, opus.  
Mp3 and wavpack are first converted to wav before normalizing.

#### Example

```shell
ebu-scan AudioFolder/*.wav
```
Sample formatted terminal output (and also written to analysis.txt):
```shell
File                  True Peak  Integrated  Short-term  Momentary
                      (dBTP)     (LUFS)      (LUFS)      (LUFS)
FileA.wav             -0.6       -16.8       -11.2       -9.5
FileB.wav             -1.0       -16.6       -10.9       -9.4
LongerfilenameC.wav   -0.9       -17.3       -11.7       -10.3
FileD.wav             -1.0       -17.5       -11.8       -10.5
```
