Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09928136B
	for <linux-modules@vger.kernel.org>; Thu, 21 Aug 2025 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817870; cv=none; b=gkcQetemDygbz4V8pveqKG2F0tdbSxBndYfIVL7d3EuQT//FqFMrk5tnWnpd2F61UkV7oK9tiXl225UDGriHr20slX3b89EaNyuUqXLNMNfHzun+1CVG8ltGNuhdJ/J2pBivvtC9Z6g+kRd7oXg0rgElNQsIEqN1aXDxskOhwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817870; c=relaxed/simple;
	bh=oyKY07/INwHK5W8rJvhyC42nOS23W04zRzQQa6+Y5HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1/0tKD4cIK3Vn5U2Qu1e/oZejRbFrABvAu5LvxN42BjYMgmSFOIjpzBXdUPUv2mA6IKOc0XGb7lPn1jskH8L8hN44IIZASa0LRt7IoFQ86+1zebzeoqBPx/WXscEIpn3Bwkxx+1A+QJYQE+nesUgrEHtg/k+gsZLWnmjKmcfUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FoDWQDRV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FoDWQDRV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24611734e18so33955ad.1
        for <linux-modules@vger.kernel.org>; Thu, 21 Aug 2025 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755817868; x=1756422668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyKY07/INwHK5W8rJvhyC42nOS23W04zRzQQa6+Y5HA=;
        b=FoDWQDRVJdAAy/6b2n/cI05N9Kz0auaOdpSOMm6BjTMuWsuh35Qxqr0IJRnIAWwyb2
         v49M/SvajLhGEy/gNuJixKIt0XMs+NmeKf1lnZv8+yV5bpDMheBB5eq5AarB/zctIJw8
         LVhHcXy1UTtiMqFGiWyIdAycNDXhN2JYM0f5iYUPEY0ol1rnYpMv9TMa7ELe0LA1jgiL
         +fFaKW+KNloi8GuoLo9CrPqLm8/SqMR0XmM9wXbGpIDTSC/NYFyXryoTd0DKYsAPPGsJ
         l0uLHnf/GrWm972CnEJXM2mPv8JwMdVrY1Mn3mouBvkPP7IEyDMQ9ov/lR8Z/oSRpaNp
         reKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817868; x=1756422668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyKY07/INwHK5W8rJvhyC42nOS23W04zRzQQa6+Y5HA=;
        b=H97BL/BaPjxqlhHcf3hOSux7gv4OUq4AuUNBofoYM/Yc8TB8ol4z2hiPnkeNwqybwY
         o7JVLzWpxXBelpyJYTjomvd645Tvt0eapbrQBccaw03SsmP1FC/h88JJ8QFOlubFijCq
         GUu88kxYWyQd1SiLuk7iUBQSDpokIzkl28zQvWwk5cHQY4fOnsyX8AmAbKcB0f5JQJaU
         6tFj6OjtH7wH98+goaMXHy2gituWfri7Ynz+64JJeUU+HJeim7y+APL6O4J7KRywTr1w
         B1Qdg0HNvwU9ZwT9YVsaNmWjIt1Ktj703HtmrDZwzvrWHnCbaenRNjOy9nePPx81JWL/
         5SDg==
X-Forwarded-Encrypted: i=1; AJvYcCUYdE5+RvUEUvWAmDIMenKC9QGWpep+EZ3g+exOTvrXB5bhDZZoB5fkamFJpGtPUVN6MB89U5O8QpR1VrwV@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqwXznGpcbU8UmpjUCRz9VnN3o3OgAzXy0dms0zVZsR0CUrtL
	lXWl4D4CcoSScL3+aUmKYwhiA/eC/SC1TIaWJVRJLYVBdSRKgi+/2EqAz7zhpamZCCsCXm2dTsI
	8QNIerXiGZto9WO/GiVE1Wr5e4bCa95sQKt8uXOea
X-Gm-Gg: ASbGnctkPXhCyw1Qz7YK7w5Qz10TS+E0QhyHXvA5TDjr/VpQ0jklWxFvtppbVtPeiSC
	h+YziksZaZ/ubfeVkef3s0iqIobuZVqdz67gMkcNBKRqU2SKDEYnZTBcapXV5fnHVmr1klTpUEk
	9tQOswN63eZ0/EK5Ne1YPjwkILEN3o4i1wlnpgr/gy3RhVbFT/kDlJRoVXZJEZsiPw/q76Aslfp
	QNjsBeBOa8=
X-Google-Smtp-Source: AGHT+IHMkq+K12+g+sEPaH5nrWLu2Vc9mkfwX/OMztYDbNCV9MMh6/uJ9JXM5YbjnlbFQzgQhGYYxAZQd1a2jF+Uodg=
X-Received: by 2002:a17:902:e809:b0:243:597:a301 with SMTP id
 d9443c01a7336-246327944afmr1835075ad.2.1755817868075; Thu, 21 Aug 2025
 16:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819121248.460105-1-petr.pavlu@suse.com>
In-Reply-To: <20250819121248.460105-1-petr.pavlu@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 21 Aug 2025 16:10:31 -0700
X-Gm-Features: Ac12FXwQzn6UYBxjGSTs2pNIL46Ww1C8DAoY0lOp82FnSFRz3SdaQdQtgKNLjWI
Message-ID: <CABCJKucZ1WxDzROye-7cN3wFujV7k7pLsLXLd3Uk_fpgn0XVfw@mail.gmail.com>
Subject: Re: [PATCH] params: Replace __modinit with __init_or_module
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:13=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> Remove the custom __modinit macro from kernel/params.c and instead use th=
e
> common __init_or_module macro from include/linux/module.h. Both provide t=
he
> same functionality.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
