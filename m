Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBD1A7241
	for <linux-modules@vger.kernel.org>; Thu,  5 Sep 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569596; cv=none; b=rFDVFptMDYHQLlti0q6xN7OTTpofoF5GIhpmy+EljcY7JaOHsv1OnbiDIRA8YyMjrZiijXlIuKRLlqlNHENIeZnGRbFAvJPHWRzVxELEQuS+7DdNPMglETGyJEr5EJK0eRZc1mr5jZDHjdw0hbTNaXFY+/HVtXEdfMxB+0jfBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569596; c=relaxed/simple;
	bh=BCPHjrxa/2c46cQlwvtBcorPbkKjJ57wCHWPzKc0gYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUGdlFVQlVraOKiqwXhCEtcNFxcYVxqDa51S9JfuUpaTZUj3WSHQDVIpaHZJMVVaMbVTP7bUTAGBSDFBNtbks292gixw3IzOxWQ6Sb+oiWPRyDlQ5kkcZerKXd8JucsmmLnGLrYAwqQos/RPH8OeTHi/ldMurpmVRjr4E7fS7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6jfJn1C; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6jfJn1C"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-457c6389a3aso23111cf.1
        for <linux-modules@vger.kernel.org>; Thu, 05 Sep 2024 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725569594; x=1726174394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCPHjrxa/2c46cQlwvtBcorPbkKjJ57wCHWPzKc0gYU=;
        b=F6jfJn1Cwaob9wTLKZrSx3fiAtOZnEJQuPUIWsWAUBO1Z3y+q9UMPdwGmDVg7AmeU7
         MxRIRdTkWkekJGAB5eB8ft7uvUGMKSTI46ekfguNGz4DPoU9rWOMbGgTiR6MJiciBhaP
         kt4J4BV/SF79VeUHCAb50yYUwzvcVte1irZRTX0siVvxCS09SqnhEkfelhxHQIbYo8e+
         vejStRVe6oHLihgU1bv7L1Ee1TY06TYjly8sOjNIWzVaSBSA/G02OvzJYoqlFOajWMc4
         2a/y0Xyry4GVLdwR+q7PCIFeiH6fCz+oh1zRygGsFPY0tFH5C4E7zIq7yPC03VAuxhUD
         KxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725569594; x=1726174394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCPHjrxa/2c46cQlwvtBcorPbkKjJ57wCHWPzKc0gYU=;
        b=VzhuNy5vHhuxH4/n0ezUQRJNUCV8y0I64HtX8ygEfHk5Gu7CpPO1OsdD7bDmr0KgEM
         g4FmPafieosMZO2dtooommBXElq8dxgPoGkPA2AXlw3NTD87cuevCUY+9h+Y+BalZl44
         rMcN7dma4Hmy612ixkOrNznWPmusv1rzbYfX4bLys+aT+GDFMGzHOhEE26zi0k9VLs4r
         ptF11FqEJ1YJkmVltNm0XyMKQGLg/HpCj18bAx8kQr4t23rRcJoFeZRk5XVlTssuqzJe
         YWEGLT6PAfHmYgO2PkUB+r++B3eQOCZTk1aPWKxtQffjZGBmdHHEcMcYL2dZW3budAvm
         Yitw==
X-Forwarded-Encrypted: i=1; AJvYcCVQVDsIEH469zS1uhpFuNonv7Em/l2IZkUjQKrquCpYiI47b6wEh3sCwyC2yLmU+9/ucY9NK4TVFWR3cwK8@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxaMmwIEWs8DBepjb+pFtnl5xqOhFW1aF0meqsiovpmrkt/D1
	7nHtZguBb/LzdeeZlGYizkObMNVCyf5UO/pmnMKT7ryctNGunAW4Rw+v4Ak7as+4qkRTWZ8UG1i
	ggGOmoHV3KAzSFihdmft52O+pWiFMQTbp+6mb
X-Google-Smtp-Source: AGHT+IEyDq3JrzaEs03Q1q6474Lw72SpaaWbS1WNHPASK98Yp/ym0+RHgGQfwZR8C+mk4SWq/i0+5v5gojSd3ZhoK8I=
X-Received: by 2002:a05:622a:1486:b0:453:5b18:817 with SMTP id
 d75a77b69052e-4580c4346c9mr987391cf.6.1725569593602; Thu, 05 Sep 2024
 13:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-22-samitolvanen@google.com> <CAK7LNAQdutCiBkWtA6MbVLpfhB-MQXnszQm8eEiBZpeX++5eLA@mail.gmail.com>
In-Reply-To: <CAK7LNAQdutCiBkWtA6MbVLpfhB-MQXnszQm8eEiBZpeX++5eLA@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 5 Sep 2024 20:52:34 +0000
Message-ID: <CABCJKucott2g8mZyJ0uaG+PdPTMsniR7eNCR9GwHpT_kQ+GFvg@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] tools: Add gendwarfksyms
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 5, 2024 at 2:30=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Fri, Aug 16, 2024 at 2:39=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > +++ b/scripts/gendwarfksyms/gendwarfksyms.h
> > @@ -0,0 +1,78 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2024 Google LLC
> > + */
> > +
> > +#include <dwarf.h>
> > +#include <elfutils/libdw.h>
> > +#include <elfutils/libdwfl.h>
> > +#include <linux/hashtable.h>
> > +#include <inttypes.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
>
>
> Could you include external headers first,
> then in-tree headers?
> (and one blank line in-between).

Sure, I'll reorder this.

> Also, please consider using scripts/include/hashtable.h
>
>
>
> How about this?
>
>
> #include <dwarf.h>
> #include <elfutils/libdw.h>
> #include <elfutils/libdwfl.h>
> #include <inttypes.h>
> #include <stdlib.h>
> #include <stdio.h>
>
> #include <hashtable.h>
>
>
>
>
>
>
> If necessary, you can use this patch too:
> https://lore.kernel.org/linux-kbuild/20240904235500.700432-1-masahiroy@ke=
rnel.org/T/#u

Thanks for the patch! I think this would otherwise work, but I also
need jhash (or a similar hash function), and I can't combine the
tools/include version with this, because it ends up pulling in a
duplicate definition of struct list_head. Would you consider adding a
hash function as well?

Sami
