Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3p0tdW1"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D67BB8;
	Mon, 11 Dec 2023 02:19:18 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d3c7ef7b31so39978697b3.3;
        Mon, 11 Dec 2023 02:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289957; x=1702894757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DkN0tHZlCkKffHLu6L+qt5GhzpSAiLqTs1J/+dzqaU=;
        b=Q3p0tdW1izOe8OYQgel6hPl4GKHNZcUCm0pEIDpVoQ/n1XHXmzVAO9RbEL7C6/mumz
         3h6wrrjrfen/SLDNnPSfB2axgQ/V52qoMPRfaC6iSM2O4Gsij1N0nDSlhDDb1Azq6Ioe
         2uF3BW6uv6nx/xwVU0WtP0oE2w2Dfi2F8fjCdQpVYV22vxQk2F2t26mYx2aboU9ETb28
         lRxayHQ07h7u+xzBtAJM3fgKY1Z+3ZRHvjzIAk4vo24kH8E0xFEDVqyOIUC3QymtjnFE
         rg+vJQ1K41c2sHXYUnu+39F0y/OiaYciHS32IH9DxeBwb48BqrXpdOXDQWaLqxloTVTP
         EGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289957; x=1702894757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DkN0tHZlCkKffHLu6L+qt5GhzpSAiLqTs1J/+dzqaU=;
        b=kp0SQTegdfWBtIWEKTfqS9YD7VSnqCXMfza8tgEQLCZDAhfPTfoYEnX3CEPK4gE2nK
         OkJOK5YGOVwNSK+6t131ztbbtVvffesA1EHyEB5OVnq3rZ68RV6qguNpXiGsJ/1OGHUT
         zuMU8VQfsrdV5fXnlc21xmdZOSwU/x27ULhlHn470Qa3rgojX8SiCcpcQg/g4iRaFzG7
         DnXzZl8UK4abCY4/NWSu04wJgIJ9NTl+a7CaKmjt5+YaBV3Gs+AM+1Qnbe2JFEwcbIv+
         7r2kqBh/aq7tw5bof0ZyN6n8Rd3XagENU6qPXPoVlqMYQmMJm+DN32a0Fc2EdQ104Adq
         YBfQ==
X-Gm-Message-State: AOJu0YzGh/ACcxXHRr2Q9sGvkxRqGKmzPSIGSPwqDq3i5zBv2erujx6c
	jcfaLxtGFfhVX6klldFtkDPZ4KVHjE+IzZGf33kcwdYiG+k=
X-Google-Smtp-Source: AGHT+IE9HoMOQvCqkHte3FlRv8RPza5Ld4Id0b6DjQ+Zr5VA7M5J/USUgsuXmpOUNvMBZ9eQfEa+zf2XsZYFvXPeRXo=
X-Received: by 2002:a81:83ca:0:b0:5d8:cf8d:4b0d with SMTP id
 t193-20020a8183ca000000b005d8cf8d4b0dmr2328716ywf.34.1702289957392; Mon, 11
 Dec 2023 02:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
 <CAK7LNASE6H2GoXzJ1PXWEqsemQ3ny1K34vOxN0uVn1fh7Mmt5A@mail.gmail.com>
In-Reply-To: <CAK7LNASE6H2GoXzJ1PXWEqsemQ3ny1K34vOxN0uVn1fh7Mmt5A@mail.gmail.com>
From: Tom Cook <tom.k.cook@gmail.com>
Date: Mon, 11 Dec 2023 10:19:06 +0000
Message-ID: <CAFSh4UwkXyTnECgJBQA4uBqD0QOFiUBvj=aOy7qzXZqAZKYkcQ@mail.gmail.com>
Subject: Re: Building signed debs
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-modules <linux-modules@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 9, 2023 at 6:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
> On Fri, Dec 8, 2023 at 8:14=E2=80=AFPM Tom Cook <tom.k.cook@gmail.com> wr=
ote:
> >
> > I'm trying to build a signed .deb kernel package of
> > https://github.com/torvalds/linux/tree/v6.6.  I've copied
> > certs/default_x509.genkey to certs/x509.genkey.  The .config is the
> > one from Ubuntu 23.10's default kernel with all new options accepted
> > at their default and CONFIG_SYSTEM_TRUSTED_KEYS=3D"" and
> > CONFIG_SYSTEM_REVOCATION_KEYS=3D"".
> >
> > This builds the kernel and modules, signs the modules, compresses the
> > modules and then attempts to sign the modules again.  That fails,
> > because the .ko module files are now .ko.zst files and the file it's
> > trying to sign isn't there.  Full failure is pasted below.
>
>
>
> Modules are signed before the compression.

Reading back through my earlier email, I wasn't clear that when I said "Thi=
s
builds the kernel..." I meant "`make deb-pkg` builds the kernel".  I'm not
doing anything outlandish here, I think, just expecting the build system to
work.

Regards,
Tom
