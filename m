MIME-Version: 1.0
In-Reply-To: <1405971232-1187-1-git-send-email-danielhilst@gmail.com>
References: <1405971232-1187-1-git-send-email-danielhilst@gmail.com>
Date: Tue, 22 Jul 2014 18:27:10 -0300
Message-ID: <CAKi4VAJiMMpNO8nmOruoujy00g0T0-5iQccNcagjyf9CKkn4Zg@mail.gmail.com>
Subject: Re: [PATCH] depmod: New option for m-i-t prior 3.6 compatibility
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Daniel Hilst SellI <danielhilst@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jul 21, 2014 at 4:33 PM, Daniel Hilst SellI
<danielhilst@gmail.com> wrote:
> New option (-N, --no-relative) create databases with absolute paths.
> This option is made to create databases compatible with
> module-init-tools prior 3.6 version.

What's the use case here? Do you want a newer depmod to create a
database to be read by ancient modprobe (from 2008 as far as I could
check)? Why?

If it was the opposite (make modprobe to work with old database), I
could understand. But I can't really see why you are doing this here
and it just sounds crazy to me.


Lucas De Marchi
