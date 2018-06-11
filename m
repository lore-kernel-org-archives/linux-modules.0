Return-Path: <msuchanek@suse.de>
Date: Mon, 11 Jun 2018 19:42:12 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, linux-modules
 <linux-modules@vger.kernel.org>, Ferry van Steen
 <Ferry.van.Steen@citrus.nl>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] libkmod-signature: pkcs#7: fix crash when signer info
 is not present.
Message-ID: <20180611194212.4570f7eb@kitsune.suse.cz>
In-Reply-To: <CAKi4VA+=Twgsz_6vEyuGx=pqYBqpZO0fcqWrukqtMc7R-9EtiA@mail.gmail.com>
References: <xunyy3iw47ih.fsf@redhat.com>
	<20180608171015.2211-1-msuchanek@suse.de>
	<CAKi4VA+=Twgsz_6vEyuGx=pqYBqpZO0fcqWrukqtMc7R-9EtiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

On Mon, 11 Jun 2018 10:12:10 -0700
Lucas De Marchi <lucas.de.marchi@gmail.com> wrote:

> On Fri, Jun 8, 2018 at 10:10 AM Michal Suchanek <msuchanek@suse.de>
> wrote:
> >
> > Reported-by: Kazuya Saito <saito.kazuya@jp.fujitsu.com>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >  libkmod/libkmod-signature.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libkmod/libkmod-signature.c
> > b/libkmod/libkmod-signature.c index fae074e6dd1d..782e96f69fef
> > 100644 --- a/libkmod/libkmod-signature.c
> > +++ b/libkmod/libkmod-signature.c
> > @@ -166,7 +166,7 @@ kmod_module_signature_info_pkcs7(const char
> > *mem,  
> 
> What's this based on? There's no such function in upstream
> 

The patchset it replies to 

[PATCH RFC PKCS7 asn1c 0/2] asn1c version of PKCS#7 parser
<20180308135810.4309-1-yauheni.kaliuta@redhat.com>

Thanks

Michal
