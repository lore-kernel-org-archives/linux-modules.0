MIME-Version: 1.0
In-Reply-To: <1444232218-22150-1-git-send-email-philippedeswert@gmail.com>
References: <1444232218-22150-1-git-send-email-philippedeswert@gmail.com>
Date: Sun, 11 Oct 2015 15:59:05 -0300
Message-ID: <CAKi4VAKvhn53jSHju9_wbXtt_Unhpxayf3ayKq5endOG4LzxDw@mail.gmail.com>
Subject: Re: [PATCH] insmod: do support -f
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: philippedeswert@gmail.com
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Philippe

On Wed, Oct 7, 2015 at 12:36 PM,  <philippedeswert@gmail.com> wrote:
> From: Philippe De Swert <philippe.deswert@jollamobile.com>
>
> The -f switch is accepted by insmod, but silently ignored. This
> causes the user to wonder why things don't work. As insmod is
> most often used with "evil" modules, -f is almost default and
> thus needs to work.

I'd encourage people for actually *not* using -f.

I have mixed feelings here because this is disabled in insmod since
forever (it's already on the first git commit from module-init-tools).
If anyone knows the reason it would be nice... at least to include in
the commit message.

Lucas De Marchi
