Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA35156654;
	Tue,  9 Jul 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519710; cv=none; b=PX70eDJR1TtkB9cfBiZ4DYNeLyYB1DoREUVVaCA6IY58+8u/tZflyXZ9yk4eQCgrOQDve1LeJnKMt4rcUVaHWq0xe3wDdb92Xe80h35V5/PNqJUeMmRJZZnqIw3pRc27DDRiCnrNKdWLapSUYL/XxQ5yvRiarQy7Mbr1fEP7ViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519710; c=relaxed/simple;
	bh=nWj7z1TorOfWyEp+z7svFUdKhlCBxkJriO3mSH5MqNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UilBH7rwE4MdGCnskaibUYrkMS+tEOAHSZV2pEYYa1TLky4L+fXzWl+FGGBEfyN0jag9Vf6UmR3Nlj8M+RmDQeGRqHkZ8wSLOi+OUBJTKlYGqBao84XQkcwVngl2OQJ9Yi3/raDqZ9FqRar52vSblLMelxu4NnNzb3FxEae4OLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egnpSShm; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egnpSShm"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c965efab0fso2915452a91.3;
        Tue, 09 Jul 2024 03:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720519708; x=1721124508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWj7z1TorOfWyEp+z7svFUdKhlCBxkJriO3mSH5MqNU=;
        b=egnpSShmb9edsXpdBTB9CUFhCa1AwKvluRevpRC41oI0wNcpi0MMJRLcDcRXYMwii/
         OVGTtTJQ4fOHUy7FMWfH0ubzjmme1tjpWERTgy7agf9nWG5yu4PinEYEKPAYetMcZqKo
         i17Mn4AhvMc9jn6fRDX6/g5BKsqQ1LcJ+cM8IH4oWbHYsZKath/qey0cDoR1LgbM6GTT
         CG8pmI3Uedg33k3GIal7Q4vKxGDLwtIPhSty4JDfAerV2SPdzb/bADF6cAqQjOQP1/uq
         fOX3lF6I2Kf2wqnt+Bdjq938jbaO3RiQxaDCVnq90oEi3ad2I/Z4T63oBmPthEr7nUKB
         r4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519708; x=1721124508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWj7z1TorOfWyEp+z7svFUdKhlCBxkJriO3mSH5MqNU=;
        b=jGvNj3mF9NvSECmrsRTitGGQX55uyJMkxXEq2IDYaiNgVWl6dtHxgSsuB5TQyM7Uf4
         hcKo0nA8UEJ/6o1OPEtp7gBSrRtc3wLBIV9m5+cnYEtaEpOzEYviUT0sElodPgJBg9bl
         PeR1dV/y9Tc1g4WhoHeBn2mvagBxUxx7f3LP5rvJpn20Kj/+e66C6RZKz4gXwlrtzsNQ
         63SS2Tbp+10XLal0rorQm5TU0ma6ESCdKZOwkf7mEjx2Ll8Jn4j4GIIX1ZcTzmV20mbB
         3GIYxBkQMeDcVNp5deUGu+cv9lQGqvPeFIzOaWQW/M2mk7eK9wmFJD9f0Yoeatz7vtcS
         2AQA==
X-Forwarded-Encrypted: i=1; AJvYcCXLmy7lXZxpP8OSE9rko3no5EuaNuWr6AATooWsmPaEVmgUBFUM3Q6sg+B0cQMBGJsQecBXZ6H0lyFgn8t4ZR/Pms8070fE3GjON5We0WaBW8hRxn3tLXKNsB3NBP0Aefq1rnAZVHF0RBPwPptMIfXLjTyQVPFIm/xbt0q7JGodu8xkqJN/gy22Q4X6
X-Gm-Message-State: AOJu0YwIrf1c2mZdMNlFVUUuLNrMN/LIyX9L2wVuMnKRZ2cCq4KAQyOD
	jWpuz9oKeYKIDFC/Aib8zcsR+k4XBQWyvQY2UTNcjZG16exSu/FzcPq11e0cuHwP6/nVBOvOLsu
	jLt6Zao9vT0GklGrP7+/yMrX+ROo=
X-Google-Smtp-Source: AGHT+IHld6WdM8gyICJ9UQ7iwE27i5HdUoIjn7RXg8Wy49Z5KwCbryiZ6Jujq/ORtNhFyAz2hQmskxPe2HS4RdJUfiY=
X-Received: by 2002:a17:90a:bd87:b0:2c2:e45b:ecd with SMTP id
 98e67ed59e1d1-2ca35c3aa03mr1507835a91.12.1720519708252; Tue, 09 Jul 2024
 03:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705111455.142790-1-nmi@metaspace.dk> <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
In-Reply-To: <ZoxdRjpy2hRndqmc@bombadil.infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 12:08:16 +0200
Message-ID: <CANiq72=VU+PHfkiq8HokfeCEKvQoeBiUaB76XbW6s3f2zYmEtA@mail.gmail.com>
Subject: Re: [PATCH] rust: add `module_params` macro
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>, Adam Bratschi-Kaye <ark.email@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:42=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> The rationale here is that a rust binding means commitment then also
> from fresh blood to help co-maintain review C / Rust for exising code
> when there is will / desire to collaborate from an existing C maintainer.
>
> I realize this may be a lot to ask, but I think this is one of the
> responsible ways to ask to scale here.

Yeah, there have been different approaches for this taken by different
subsystems -- it depends on their constraints and how much the
submitter can commit to.

For instance, some maintainers may want to keep being the maintainers
of both Rust and C. Some want that the submitter becomes a new
co-maintainer in the subsystem and eventually maintainers both C and
Rust. Some prefer to have a new maintainer for the Rust side only,
i.e. considering Rust as a new section of the subsystem with a new
`MAINTAINERS` entry and all.

On top of that, some allow the C and Rust sides to be independent, to
the point of allowing temporary breakage on the Rust side if the new
maintainers commits to be quick fixing it (though I have my
reservations about how well that would eventually work if more
core/common subsystems start doing that -- linux-next could be broken
a lot of the time for the Rust side).

But, yes, I think Rust is a great opportunity to get new
co-maintainers, as well as getting new developers involved with kernel
maintenance in general, which could help with other issues too.

Cheers,
Miguel
