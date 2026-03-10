Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C22D0C89
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148801; cv=pass; b=J+CnRi3Hc371vTeW2RRIFsQfmzO0z0XvEiJoSBeb/m01xZk8DqMSaplDK06ygKvmURzeX7716VwUa2N8GBjfUEMqT4Zz1jNqEAflvs15U1uDQd6qdV0eosbDZtnmDd0HU6lS1G1+tTYvpW7HDDwosui2vjgXs0eaGQSNc+7fwMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148801; c=relaxed/simple;
	bh=Bpi4yrgVcxsgd02XmFGnNmMPP+pfMJQ+GDSh5ZimOUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azfXX3/scV6f7MnEHMYXcu8ED0ACz4jHghUOqNM2BLjad0lSk0kb4eydB+HemdIgfsU2kUHCWuA93qrTXbzFYiS7hyW6oY1CQ0wMxJNE/hlOQnjw1qIgFD9rj0coEZ7ZFoGs4BMD6aV+6F/6NBQFy/KqQQq0HeX/Y90GYlX7rGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzck2hum; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzck2hum"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so12525346d50.3
        for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 06:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773148799; cv=none;
        d=google.com; s=arc-20240605;
        b=F1ZP+Q0fEplFtdILApcF4KYr+d1f61gw5arlfZWeuzr3Xdu0u1qSlwhFBlq5YMCNZQ
         y9F1F+GP1jRczOIJqnTS4lPxP7ekmuVGFrKK8mZ15j9R4hQnm5XrvsD7Zjg2Yq1ZJckz
         jmtAJHpLOWpd1OIvfk9LwO8pYRasQR0lknn9nW25B8NaPiI0Bx3hl4Tc9OFCMIalohlB
         WuBgc9D4FfCP7GlQC6h7UnaqE2DHiS/i1qkbzx6iifxr+02oCcHmTpgYSqs+rlxZVUJ5
         y3R24hJVL7wbJOGWxMRo0IZEODxZb2ad2puDfaNMEe/lBkkUHD+N0ZfNNqhJ+5R2VHTg
         zvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dT5fOZDkj+eNTr49ss8NqBZLY1v8JI97fAvhy/5Fh9E=;
        fh=Q3fSLSweqxcxGzz3+JqDzKY1QWRXM2YNlxd1+d9PpNo=;
        b=bubuBWh4ecHHTqf7xBU3FndOChs43hGQO8PzafUhATULwPj+1NkFZvPG9Vvw+QGAvm
         5EyPIddvN/IfSMisc7V9j+dStAhoqCTr2BKzLmyJoJ/J+xEfPgy+Sda9FQqNe+2AJxNw
         G0agStTiPk2G/qANiTyMYVQ4D4Soo/64QEWhRSLbhUAclTYFULykgtNCXnZYr91e8wxK
         OQKib9jfE7XB2teRXNC80XUCurjqpxUhwTSlW6uKJwflzj9EOd2nYS/bRQDvC+uxaQNL
         YnzgkZIsbmllfwBuZxpdwDcmKYjOyvCvUuY9wkta3Yqd69JqY8eYuxixD3c6/G7TBuJy
         QxEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773148799; x=1773753599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT5fOZDkj+eNTr49ss8NqBZLY1v8JI97fAvhy/5Fh9E=;
        b=kzck2humhvG3ZtegD5wlI6bLXmoaWvXjFPaSl3z2cVHMNtXVRkL5OgQBYcCeLtdgzX
         ujkLPnKpvJrkiqiuN3WGfpkF+Sj0jX0Rp9duo8tHQGZCGgQFT++WmyNNd5fcxds4BhDT
         tafm9oEhhFBTjJuimCLgPpE1OyrZZdHVoSIdGjSbfTKKgaX0zEgZ6e3uioIptvitptN0
         8KxrUu2rLauSI4ywoi2KVyM1TWd90QlKRwMaBF7Uc9l5eqEv5qvaBCQdOfSw3Li+DMfd
         34fYi6FC3rhfNue37MMs9b0Ul/wx5y9d5BiwwOG4Q+MhJaDg32rstwf28HhR6Ev0CcBZ
         JrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148799; x=1773753599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dT5fOZDkj+eNTr49ss8NqBZLY1v8JI97fAvhy/5Fh9E=;
        b=bV4GzfOOUoycKBXdWjk19r16/gRDQfXmad/I1o+NtZVXYPlorCP24nh7SwM0ruwoty
         0JEGpHpU9doEF5hUpliHAsvChsO4kKMNFF+oRslxxxndW6viESvc5VwvqEo7lIjygsiw
         sg+96FJWjyuJqEkTD6+NkSOF3LuFxHQUK24b6VNPbTm2fAQ5eMhOPTVDYLuV33OpFULh
         uBs6rpd6wLxRCkDV5iXEZ22AvfLXHpNAAifine2GfukCfNfOC+m7diwN4VR0DW2M7S0S
         Kswli1emW4QKQCA2gAAxHZhBvSg1ntC7GKdC8SIOmlTpZPl70IbTielM5DX2c9ndcQxy
         ubsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/4yiqVNAbnxf5QN9EjkOtW90vTZ+yfRXOpHOL2ZH/2pZXpwaxyvA5k692YI0DSNegcTLEnpOflUVjGFPd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Yw0yke3kg+oN29vpL7t7wbf5I8//c+j3HzWNciWAq81D97RO
	UxNEKn9AvTaP5EY+yuloGwZ3xJmW8IYPPpRQDOmUKDK7dV5Y6t+6MNnyvKDI7P0CJnK7vcZD54a
	feOTzbyPiEAVRRTNJdvSLTG5QOJT3+Mg=
X-Gm-Gg: ATEYQzwXG4+TBzxKRd/6jkZoV50/s887U5RPGroKyIKGKH24cyzBnhyvV1xcEWnSQ7c
	+IfCKSEIQPHg+vPqfRhzHyOXrXT0yMXwMXWl/PMN2LfmneVbdft72fWHXk+PUxNKrHqziKKMhi8
	BF1cUspRNWJ3eOVJ2aQPGRdYo5qAWhBJyUDy3WaJ1Bf+pLohsqclDWUm+Li/0JXRibVlWZjFFMa
	Br8nnvmAo26YXjxyrHjKIO+Donj6QMZVDW3r4zoysWFIPk0Kx20REKwaTgm2WxBV78xpYF5j3IQ
	AsMUM0sq
X-Received: by 2002:a53:b186:0:b0:64c:2581:eede with SMTP id
 956f58d0204a3-64d14302e2amr10658171d50.72.1773148799088; Tue, 10 Mar 2026
 06:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa-6wILF90Y4ndnd@infradead.org> <4215f061-488b-4c2b-98b3-45db4aabed5e@gmail.com>
 <abAXjc6OihRcdoAA@infradead.org> <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org>
In-Reply-To: <abAZSCbSEGUhTdUn@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 10 Mar 2026 21:19:22 +0800
X-Gm-Features: AaiRm52c4wzVJC1grFH3zpsiIMizc7_zmeO-Hsuu-y706NcoJ5ilqxAX10GrTjA
Message-ID: <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
Subject: Re: [PATCH v3] module: print version for external modules in print_modules()
To: Christoph Hellwig <hch@infradead.org>
Cc: atomlin@atomlin.com, da.gomez@kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:14=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Mar 10, 2026 at 09:11:48PM +0800, Yafang Shao wrote:
> > > > Could you please explain the rationale behind introducing
> > > > EXPORT_SYMBOL_GPL() and TAINT_OOT_MODULE ?
> > >
> > > Your straw man doesn't make any sense to me.
> >
> > This solution has been approved by all MODULE SUPPORT maintainers. Are
> > you on the maintainer list?
> > Please help keep our discussions polite.
>
> I don't know what your are trying to say.  You brought up a totally
> unrelated strawman argument, and when I remind you of that you're
> arguing about politeness and maintainer files?

To reiterate a point that may have been overlooked:

Given that the Linux kernel officially supports out-of-tree modules,
we should aim to support them where reasonable. My change is generic
and improves the core code without being tied to any specific external
module.

--=20
Regards
Yafang
