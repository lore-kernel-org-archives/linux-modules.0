Return-Path: <msuchanek@suse.de>
Date: Tue, 13 Mar 2018 10:57:39 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, linux-modules
 <linux-modules@vger.kernel.org>, Ferry van Steen
 <Ferry.van.Steen@citrus.nl>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] libkmod-signature: Fix crash when module signature is
 not present.
Message-ID: <20180313105739.748518b6@naga.suse.cz>
In-Reply-To: <xunyzi3d9gcw.fsf@redhat.com>
References: <20180308135810.4309-2-yauheni.kaliuta@redhat.com>
	<20180308181426.5617-1-msuchanek@suse.de>
	<xunyzi3d9gcw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

On Mon, 12 Mar 2018 22:41:19 +0200
Yauheni Kaliuta <yauheni.kaliuta@redhat.com> wrote:

> Hi, Michal!
> 
> >>>>> On Thu,  8 Mar 2018 19:14:26 +0100, Michal Suchanek  wrote:  
> 
>  > The mod_sig is allocated on stack and when no signature is present
>  > it is not initialized and contains garbage. Later when freeing
>  > mod_sig garbage pointer is dereferenced.  
> 
> I guess, it is enough to init the structure.

Yes, it is enough to initialize the structure. However, this issue is
caused by the awkward interface to the kmod_module_signature_info
function so changing the interface should prevent such errors in the
future.

Thanks

Michal
