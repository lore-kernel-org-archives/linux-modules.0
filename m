Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC973816F0
	for <linux-modules@vger.kernel.org>; Mon,  2 Feb 2026 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051720; cv=pass; b=uu005tM9dqm+giC0/iUT6Af4GA7sNBSOcWxSEeMlA4rOmOn6OL6nTa2HEFaItBgVQ5TN/1wok4zMkZ79HbivwOMHWmbPphvm1FzuAXTx1g+7vJGV2o/O52KOMC5h+Tkf/xQwFMoHSkNzuLa5D4wKU8ZVExcQ3P9BTZVfGHBw0NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051720; c=relaxed/simple;
	bh=tby2xKJCy/JDIMLTe6tfBEEsBUYRq9IGLzGth6ow2XU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atCb5bhlRxQ/fG8BFxyI3stBtM2y/CkqybcAQKbUUiKshTsFQ9S8iFzJLrTPDEfZBV/11Q/P68sS4tnRHjBiYkIOB9zcg5IgG+WowR6astqFI/tSOMU37F3qyBrILptTf35tcw7EFvEfQd1w5kF3aH1sHr5m8zSdk32YYJ+ZJf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1y6/Kpkp; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1y6/Kpkp"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6581551aa88so13227a12.0
        for <linux-modules@vger.kernel.org>; Mon, 02 Feb 2026 09:01:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770051716; cv=none;
        d=google.com; s=arc-20240605;
        b=CMx0przCpg0kTwMd4Vh5mk36diWVGAAjctDRTB5uJtZh1EQgxcKj1wt7aEwvZWGBCR
         Z12kMgmDAgbvF/oF/TLEqfxSRswyXA6sPwp/cMhKaah4v/3d7Sgg4Tl0IpKb6roYFZF/
         eWqFFKvuWb4c0PYry6n/Hj7qFrP9QzGBPy8Acw6/JlobuEw2cSfOrCZfrNWc4wPc+m4W
         uwrJ/fF62HUktDUd85cyERM+I2suDqm0WDO3Ubmu/fpY8amQOlV6oqe7J88hsh8XOu4y
         fseKWA1UlZUlFW7D/1yiFlX/BMo7IQ+2gXnd8bfv+yeOYnhpn6iWdri7pgHwixmiBnYq
         aurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tby2xKJCy/JDIMLTe6tfBEEsBUYRq9IGLzGth6ow2XU=;
        fh=X0r1Zi0dJ3VAPMDvqsziF1/6/fKbyyBx0J7qTILsf5Y=;
        b=XYI3bGBZUSVLScB6vMg3eZoFZTsv086iU2rtMIl6g1mu7syqsQtG8cJoyOYusU0fPJ
         XYOmBg8UNCkJAGszh+3iDhYOl3bVTf06di3C+5z2dDDs8hvC92jkhkNg6mMMnBStetUr
         TQm2EtQXwJGS8gOCMw+ro+uRBgqaof8ucyXlwN+ymw4xtIdday4syxVdyhGjG/7p2hGH
         MWdVqr1DiqWVwqO1hf4TvFSAgtMyPCok+RiYn4aWqRKjlkHI1mfaeqTMMYRcMMLSWLRf
         tOsgLYTw03NdGIoIEDQPBIA4ST7l6zCOVsL8ITUogyC3TP+Xd4GvwVR46N4n3NbASE8b
         rhPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770051716; x=1770656516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tby2xKJCy/JDIMLTe6tfBEEsBUYRq9IGLzGth6ow2XU=;
        b=1y6/KpkpG5A7XEpRF4GcU3wT7akPBNjUFM3tvKqhJWA0DnZzwrBXl2XeS8CBXHWQwA
         Q+DbYAZdu0TQlQ6adm6abwnlc9eUJEyqZgTg6dd3XGhelnaHll+sx876fWUiSCvn+8JX
         ng5ZDvK+pLR8Icbxxb61U6uDJzLqBi0jx69Uy40rb4ubURVLv4E674ii3YMFKNZEO1dS
         olO9Q4uHpI0rBIDIfqsM37nkOe4LHV+fBwLV90tg/rAjdX0atLQIkQnjsUDHM8trLjsZ
         i53pPVOJNSd3RztQGhg4PbqSuA9L/lUiMCxLHdCR9rJIz+3aBtrq9Kqn0MXLSbNfwSzD
         Tegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770051716; x=1770656516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tby2xKJCy/JDIMLTe6tfBEEsBUYRq9IGLzGth6ow2XU=;
        b=cz2vk44vkbpyl+lV/ZZmKKTVfMEASgYOOXPIrtH++4QsRnGv3H+4IzxM1t+EiIAkx3
         DgDTdhtwX3x7yYh3JCgFZwSZ79+2HCKegN8p6fYXww6Stl9GgE1rSUIYnlBA8amJqwrQ
         Z+eoRPXqI32oErRiBOuxG/epFe+IDrVqb+mP8J3zm879NmkgGIlIlOdo/4j4ujV2PSbl
         FUd509RkgXhi3Zz6lrh0RREqb6PKinpDw5qHulICnJEpB17Tpere6oLHlI8OnTgT0cHr
         FF0Bz8H/rG0eO/4QREGY7XouAlA2uEfoi9nRZekdxxTjKNSwm2MQgqe8T3INy0mInpVW
         21QA==
X-Forwarded-Encrypted: i=1; AJvYcCVxWY7eSCxMvwLuTtp/yQSujhcJx0EnOLg1e3PNBbKsuJ5b0HZ+/llUm6w3xsWwq5ZnCuoJ25ScLIZDtCxy@vger.kernel.org
X-Gm-Message-State: AOJu0YzWscB0aprH1F8EzaCzFkxJnp4WidSczcyV1ToMNnHGT5+XjX1B
	qpc5HrPW4Y/7FEyPqHaTwu4SGuJ4Av37Vd6Fa8+XB4BQQCXuPQm7Q87+JmU+hCrWNCPw+CmTE79
	aGAsGPODYUVId+YbpsZ1cjMl8SHEdzc4WC2QAMIV2
X-Gm-Gg: AZuq6aIbUtIiBreUp0UMzPm8A805wdRUz0GbrNfs2ma1Y8Jvjn9vWGsjpZ+mn6CsfOY
	yUP2xRjaVkV6uadBT2uhxUV1n/H5icjd6sqV2n+TF5melJNVF3PZLag0t/JRRlp2BboWKL0MJ1M
	RDe6y75wE1ELndfHQ6OSVUqgaiWe/cuwUJgmuTHHtpcaxIdOQdjsleEk2pIkOJRDuF9WQeTdEL4
	UDQWNKp5+98miA5qwMVeed2v12s2bMnOmKsvhR+nGDtGFGkpAbt3e9QmHyTqVfv7Zc/
X-Received: by 2002:a05:6402:b85:b0:658:1157:5bae with SMTP id
 4fb4d7f45d1cf-658f6c760b4mr59648a12.2.1770051715652; Mon, 02 Feb 2026
 09:01:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111154923.978181-3-petr.pavlu@suse.com> <20251111154923.978181-1-petr.pavlu@suse.com>
 <2403737.1770031462@warthog.procyon.org.uk> <640c124e-0f03-4869-80fe-20c8be7aa525@suse.com>
In-Reply-To: <640c124e-0f03-4869-80fe-20c8be7aa525@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 2 Feb 2026 09:01:19 -0800
X-Gm-Features: AZwV_Qhag7Iyy171KP5DZhq3YPTSczr6SONF8PacTdVUJwV4s37Jpcog0jCPTCQ
Message-ID: <CABCJKucAkZa10TYRQ+NxPPw3KaTq4QVk5+XZWyCPpSrpMR_GEg@mail.gmail.com>
Subject: Re: [PATCH] sign-file, pkcs7: Honour the hash parameter to sign-file
To: Petr Pavlu <petr.pavlu@suse.com>, David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 4:25=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 2/2/26 12:24 PM, David Howells wrote:
> > Here's an alternative patch that will allow PKCS#7 with the hash specif=
ied on
> > the command line, removing the SHA1 restriction.
> >
> > David
> > ---
> > sign-file, pkcs7: Honour the hash parameter to sign-file
> >
> > Currently, the sign-file program rejects anything other than "sha1" as =
the
> > hash parameter if it is going to produce a PKCS#7 message-based signatu=
re
> > rather than a CMS message-based signature (though it then ignores this
> > argument and uses whatever is selected as the default which might not b=
e
> > SHA1 and may actually reflect whatever is used to sign the X.509
> > certificate).
> >
> > Fix sign-file to actually use the specified hash when producing a PKCS#=
7
> > message rather than just accepting the default.
>
> Is it worth keeping this sign-file code that uses the OpenSSL PKCS7 API
> instead of having only one variant that uses the newer CMS API?

I agree that keeping only the CMS variant makes more sense. However,
David, please let me know if you'd prefer that I drop the patch
removing PKCS7 support from sign-file for now. I assumed you had no
further objections since the discussion in the other sub-thread
tapered off, but perhaps I misread that.

Sami
