MIME-Version: 1.0
In-Reply-To: <CAGZFCEGVxMzsihhWRZPZPDRrxUhJxULj79wu0uQ5CXHgkThA+A@mail.gmail.com>
References: <CAGZFCEGVxMzsihhWRZPZPDRrxUhJxULj79wu0uQ5CXHgkThA+A@mail.gmail.com>
Date: Fri, 25 Apr 2014 00:16:00 -0300
Message-ID: <CAKi4VA+c0g3rr5FiCf3zcHeqnKcgbqjg30q1DjSQbZ80EXdMWQ@mail.gmail.com>
Subject: Re: rmmod resource busy
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: ratheesh kannoth <ratheesh.ksz@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi,

On Tue, Apr 8, 2014 at 1:44 AM, ratheesh kannoth <ratheesh.ksz@gmail.com> w=
rote:
> When i tried to unload a module, i get following message
>
> " Error: could not remove module tun_module: Resource temporarily unavail=
able "
>
> 1. How to find  which process is using it ?

Kernel reports which module is using it.

For processes... it's not as easy. If there's a device node, you could
search for the processes with that node opened. Example:

=E2=94=94 ~ =E2=9E=A4 lsmod | grep drm
drm_kms_helper         35710  1 i915
drm                   239102  5 i915,drm_kms_helper
i2c_core               24760  6
drm,i915,i2c_i801,drm_kms_helper,i2c_algo_bit,videodev

=E2=94=94 ~ =E2=9E=A4 lsof /dev/dri/card0
COMMAND     PID  USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
gnome-she   589 lucas  mem    CHR  226,0          8096 /dev/dri/card0
gnome-she   589 lucas    9u   CHR  226,0      0t0 8096 /dev/dri/card0
chromium  22801 lucas  mem    CHR  226,0          8096 /dev/dri/card0
chromium  22801 lucas   11u   CHR  226,0      0t0 8096 /dev/dri/card0
chromium  22805 lucas   11u   CHR  226,0      0t0 8096 /dev/dri/card0


--
Lucas De Marchi
