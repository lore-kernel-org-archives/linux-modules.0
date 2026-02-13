Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835828287E
	for <linux-modules@vger.kernel.org>; Fri, 13 Feb 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004735; cv=pass; b=abMCaigSoXrch7XsqFHkSX4S1UzfLTy4Y71N84T5N0Src7aXViG0ENCyOdNWKt1Ce8YYnx3VjctL5bYzDVii4u7rnl9LAZvS28Rm78Xl4sVdF6u+WIIRdHucL+Y1Wyg1nNO2lOmHwwvv2Oxqf9dF4I4EbdpW7a/j0WyAinf8RXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004735; c=relaxed/simple;
	bh=ayFrK7Uyy/TSNgQmuVFUc3Igof5CZZ1gX6lTzzVj8Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeXon1z/Wg6azLC6ynFCoh9BLkz1ay2CIUvwWGFKBtdWutBHsE9DBqAGHKXSSRKWmAKJFaIwfOGnZYXnjFtFVqtDZ/rbxU3I2ze6Y7EbviRu7GofBc0q0TXtxctDIYDYhtlsa/gbLnmPQbfKPC9HDg61m1RAKlkz32MCbKMVpLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwznsusH; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwznsusH"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65a3a1740e7so262a12.0
        for <linux-modules@vger.kernel.org>; Fri, 13 Feb 2026 09:45:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771004733; cv=none;
        d=google.com; s=arc-20240605;
        b=aRBhljmH/6B8XhMoScsx+LhdKts0W6X4KViEX2mQGnxtpIGbh7CBVuEmemSglJ111Y
         wvFnnDf3c4QPStHKIYGx2alXFYzbpnjkaN2u6vpVmjxmVasgd9iCgWxxoVrCGXJauOVG
         QOjhflk4p61gSwYFERy2+cRATHkpJFoNuQAu2mRyg3St61rz8liG302BBzInYoG+s5aG
         IEY4q8j/bVCeuLjvKxVy+nZv3hgxZhD9uO5zjiaLvD1mMJxU3ifhlHgacF6VWw1qE3Fh
         C1M/1J6z9+qvIDjTPxY3dbGy5qqasmikH0B6Qj6h52g/b3sRPusHntqdIpYTKjV9LiJV
         kEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayFrK7Uyy/TSNgQmuVFUc3Igof5CZZ1gX6lTzzVj8Mk=;
        fh=ygAXh0cXs+Kf+yxR9/vXs2hTjW3pPww3nDlJnIw+jIE=;
        b=GTM/btDan9uvFKyW8vr6Ljydkzb3CunaRDdOaC6+YXSsjmIDClllBMWTYVNbcV3m57
         X+i7+Bwnpmkk+g3xBudL18I//imksBVzZdXKFkCjxlH/BSvtDhONayaa6r+bwcEaLnYI
         koCtKKYn5onblspBMrzOhFON8F9RsNXBsL8xQPJrd4GPWHpBIoGHjnVSmlg8K4g+pjlf
         k0treRdYyvCW4Jl0ImPdPQ4sJ2kcSZzydIMlwtFCANCJFPLZipEq8988qPLvYz+SwXcY
         SKypM8Qj7bfdlimEFUUda7+IfpJmSSmYN7YDirBw6eHyUT5GjbRC/yKlTmBcq/3CrgvA
         FrKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771004733; x=1771609533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayFrK7Uyy/TSNgQmuVFUc3Igof5CZZ1gX6lTzzVj8Mk=;
        b=jwznsusHcAbfkezvgBKotCsRXvHJpYKHz/5qGmb9xmChAJpK0z/1pHuOswcLyqtFse
         YMgLAr6t6730LOa5eSpZ+2Q6XYREdggpDeddSluqwmKHoBY/eHOlxvOgxC7j66agCscL
         4FTgJDJggv1gRE4CxTSfEcPecUJ2aHN3nq9vTizOJc37LxLOY6DhGxfUkncPtIxHpPsE
         CGONYr6zajhKNHazIvSy2KlBavd9Y9GDrb9Dik37C+Zpy7aYiXjUseHGlY6Gbk39Sk6D
         Jo6Z9JQPuC4GeyHR5DkB75/32q+sb4UGXX2GSowQoFSefd4Avi+KCFauQPuYVXtKLhtL
         enAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004733; x=1771609533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayFrK7Uyy/TSNgQmuVFUc3Igof5CZZ1gX6lTzzVj8Mk=;
        b=v5KkY74GP+5D/TXi9LyvPfhZfF920Do+Yg1gOuXtKNt99fT1KBW3Kmh/nrjqwbAKm5
         N3gwhOUBRIa+jeTozEKV7HZ5ivA2Yy/XbPNEfM61zXXSZjHcwMPiS7IID0KGQrNNRT36
         csVRpe/XK4ZHSOHW++JUJF7RpLSZafqUCJ2L9xtDrnKy5IanmcAwwya1rVPvsFcqXtGj
         jDYl68n7Ni+p1xn4dqSZmK8pXIE525jWb0CTuDED2P5xFiaH8eVzQ1P5+sxwqfRqxnyJ
         36u679pgH+C0Yar/oCna3Kvh/Od18MYtVw2l9tN7d75YrVNmHRnEPyg1KEmnilgR1P/e
         y+xg==
X-Forwarded-Encrypted: i=1; AJvYcCUBgs31Lgtxtz8QKqQHR4NPP1Pl7apmbV5Z77TqNmyZj9YLmXqWzaxhoDrB84fNAk5C6XTIzP6VwoHICe16@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3/3wd8E7IguFqo160PCeWmOiprL3l4moS9r6pWW3FNQFyvLZ
	AN3JLuwM19n2QOYAQgu4zSOgSd07FYvqL+dACfxFG7LJ3Sh6D7IkC0hq/GVpcraaxAL1ckOPpOd
	69L4WU7NFx0hshaCK4zb+b33aqTITgKH2ctTfeoLv
X-Gm-Gg: AZuq6aLu0eCimOs88t/IKZ8e1jAEAtwrkg4KMHkMd/EGlyXylLtivzumiNfV9Ibzk0G
	T0BEWn5BIY1aoHYThCKJY44J8IJgKEUar2CO6d1eMY3DZYcLdLf86Sdo3pnchfBfP38aLQezNft
	YnDBjz/UsPYgB+5BSe+6KDKVPEiCIuWsGvSF+kep5y9R4+rAvd8e7i/xz9A4j6I7v24C/CShSay
	LDqLc3NarZ1rxFouBIpt1IImdWTlqjbvwk1hocOeVWSSkgkXAFLi502x96P0UssDfzuiH9l4iZY
	YgGx
X-Received: by 2002:aa7:d0cb:0:b0:65a:3032:5f99 with SMTP id
 4fb4d7f45d1cf-65bb07bf853mr33729a12.14.1771004732430; Fri, 13 Feb 2026
 09:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108044710.33036-1-linux@opensource.nslick.com>
In-Reply-To: <20260108044710.33036-1-linux@opensource.nslick.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 13 Feb 2026 09:44:56 -0800
X-Gm-Features: AZwV_QhmtBeCGmaI1RJu4D-yf_6VgXyRAHldLsr2GyEAgPsejOdx8L4v1NNyTxM
Message-ID: <CABCJKudKtrVCUcKRFCHfAyCCA43=gni0iB4mdL5b+176Ky2UPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: expose imported namespaces via sysfs
To: linux@opensource.nslick.com
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Matthias Maennich <maennich@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicholas,

On Wed, Jan 7, 2026 at 8:47=E2=80=AFPM Nicholas Sielicki
<linux@opensource.nslick.com> wrote:
>
> Currently, the only way for userspace to determine which symbol
> namespaces a module imports is to locate the .ko file on disk (which may
> not match the loaded module), then either parsing the binary manually
> and handling any potential compression, or shelling-out to modinfo.
>
> This is painful in cases where userspace wants to distinguish between
> module variants that share the same name but import different
> namespaces. For example, the nvidia-uvm module exists in both open and
> closed source variants; the open source version imports the DMA_BUF
> namespace while the closed source version does not, and networking
> middleware may want to initialize itself differently depending on that.
>
> Add /sys/module/*/import_ns to expose imported namespaces for loaded
> modules. The file contains one namespace per line and only exists for
> modules that import at least one namespace.

The patches look reasonable to me, but I do wonder if examining
imported namespaces is the best way to distinguish between module
variants. Is looking at /sys/module/*/taint not sufficient for your
use case?

Sami
