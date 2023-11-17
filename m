Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/bNl4Rz"
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C06127;
	Fri, 17 Nov 2023 05:57:30 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-586753b0ab0so1021285eaf.0;
        Fri, 17 Nov 2023 05:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700229450; x=1700834250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZqiZe2Na/M2o6TjGam06jgQj8VYgWS8+wJ9Q11mHeE=;
        b=b/bNl4RznYFQrTDYbh6JOomtaWP9uxpPMVaZTCbPp4gCGF+dGowRLs3zjgxSG+8Ird
         JdUvl5TrwohWYKk7hUQSzhbJw5d9qzx6+jrqZ0THtgYSwyYlSGIZzSbwy5zINBvOEGfM
         4bchRBfoyR4uxCaUvKm4GYM9NTMwx+T8XPHHHza/Dn3LIUpbMF1Vfxly+++VkwIk3wsX
         +LcVrMH9j1lS2Rxw/zserUehgYxQaikxRDgRKkFLEtTrhmjRBJAy+12J/6P3uDTB6/ri
         U6jAz3MoVqI5PmSAaJApIT4PoY897qKSgutVwfQF15l/U+eyuhl+9huwqgaC/pRqeBwW
         ZRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700229450; x=1700834250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZqiZe2Na/M2o6TjGam06jgQj8VYgWS8+wJ9Q11mHeE=;
        b=ky51niPc9o5gug8+sDihbvF2TElxyhhKZyP9o+rz1z9vka7HEXFto9CfakG1sOh66q
         RHxEVQjKT5KhFE7EChkbSXtA3QwvwFaxO1uJrc4/XkTk+v4zTxMkfZBMXLIdGaQ5dMPo
         Z0+gXctH1yY0D4x6wa2Gq1XllaNEb+lNqLREX4UnMNftPiNqbYdAjT9PWrLG9YkJnVS8
         UaS8wlJu5fRENngqwrGQSPzL3IQ2yxFGO+UVZoprZdovEY8j70Mo5dqWNPOffwENNQbB
         hC0metUDDYwAFDyWAhhr2zloRod67WzpESyoTGxOvRhDNbxuiHagaWcMYmCckZK/PcfS
         ZtFQ==
X-Gm-Message-State: AOJu0Yy51C+DRpTMb90lTGiZ02UqKucZGeTS3lO91VUv2XLMsSoi52iC
	8RQxv5Hw2BUWJV/mSgOmtmx4znZY/c6EslcINEco8aegg2jGlg==
X-Google-Smtp-Source: AGHT+IGt8YOeNreqecPcygIAHwGujqNzfI1QiDHel/vlu7LoL74duxjWp0RZmpMS8lA3viykBy1GndXGqo5mEm8kGeQ=
X-Received: by 2002:a4a:9203:0:b0:581:f6d8:5ca2 with SMTP id
 f3-20020a4a9203000000b00581f6d85ca2mr18524777ooh.6.1700229449572; Fri, 17 Nov
 2023 05:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
 <20230914112739.112729-2-alessandro.carminati@gmail.com> <ZVZS4hw5dGB4aPz3@bombadil.infradead.org>
In-Reply-To: <ZVZS4hw5dGB4aPz3@bombadil.infradead.org>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Fri, 17 Nov 2023 14:56:53 +0100
Message-ID: <CAPp5cGTcRGp3z=xbA1svxLYz1LC74_AQrTPSXNmACPRYrpporg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Modules: Introduce boot-time module signature flexibility
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Luis,

Thanks a lot for sharing your thoughts about this topic.

Il giorno gio 16 nov 2023 alle ore 18:35 Luis Chamberlain
<mcgrof@kernel.org> ha scritto:
>
> On Thu, Sep 14, 2023 at 11:27:38AM +0000, Alessandro Carminati (Red Hat) =
wrote:
> > This commit introduces a novel boot argument parameter that provides an
> > advanced level of control over the verification of module signatures
> > during the initial stages of booting. With this enhancement, we gain th=
e
> > capability to postpone the verification of module signatures to after
> > intrd stage is finished.
> >
> > Given that bootloader-provided artifacts are commonly employed
> > post-verification,
>
> Is such a thing expressed with a kernel config? If so then shouldn't
> this be default for those uses cases?
>

I've hesitated to propose this as the default behavior for a few reasons:
The current patch doesn=E2=80=99t include a check for the secure boot chain=
 being
enabled.
From what I've learned, confirming secure boot mode on UEFI systems,
especially on non x86 targets, lacks a standardized method.
Considering this, I've chosen to leave the decision to users who can
specify a command-line argument during kernel boot.

Implementing a new feature as default in the kernel might face resistance
and seem intrusive.
To avoid potential conflicts, I lean towards letting users choose to opt
into this feature.

Additionally, It=E2=80=99s essential to acknowledge that not all kernels in=
volve an
initrd phase.
Embedded systems often differ in their use of an initrd compared to traditi=
onal
Linux distributions.
Enforcing this feature by default might not align with the preferences of
the embedded systems community.
I'm open to investing time in proposing conditions that might pave the way =
for
this feature to become default if certain conditions are met.

> > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gma=
il.com>
> > ---
> >  include/linux/module.h  |  4 +++
> >  kernel/module/main.c    | 14 ++++++-----
> >  kernel/module/signing.c | 56 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 68 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index a98e188cf37b..9899aeac43b0 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -34,6 +34,10 @@
> >
> >  #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
> >
> > +#ifdef CONFIG_MODULE_SIG
> > +extern int module_sig_check_wait;
> > +#endif
>
> Please add under is_module_sig_enforced. That's one new line Vs 3 new one=
s.
>
> I see the code which skips module signature verification and the knobs
> but I don't see the code which complete the promise to do the actual
> signature verification post initrd / initramfs state. What gives?

My initial intention wasn't centered around providing an automated solution=
.
Instead, I envisioned a design where users could manually restore module
verification during a specific point in their init scripts.

It might be plausible to restore module verification when the rootfs is
remounted. However, this seems limiting rather than advantageous.

To offer users maximum flexibility, I considered a solution involving a
sysfs file as a control mechanism.

The objective of the RFC I sent out is to gather opinions on this feature.
Understanding what people think about it is very welcome. In this context,
the question arises: would it be better to have an automated solution that
restores the module signature verification automatically?

>
>   Luis
