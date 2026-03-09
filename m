Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550253939BE
	for <linux-modules@vger.kernel.org>; Mon,  9 Mar 2026 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054946; cv=pass; b=djJGWEcppQa4S+NrNY0HbM6hGOkLb2LdU+/+ervRkk5R3TMJDk2ie4Eb4F3y3gNGc2W62k8Ma3AcXNjLtNDeqDyDIEFU1Cs+PAmh2Zg4CCTBEzioQ3E6EFAmGqq3t5vMGYanebnkwrp+bgInXwaSIaUMAYfZzgyQw9OZhCILPOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054946; c=relaxed/simple;
	bh=bwnTPQewhTZfBV+DUD3SsbtLeKJPcVZC52nT9OgQfwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+nDlnBDYGQsmtNxy3VER7w4PTX8umR72b91nUmmiq3j1eAWai56nHtqwy9XY2r3g03F5hT2bKd3X7SkhXsd+P5MGbDH43+m5pYW4OayPedyK8v+ZbbQz/Yw1KWwJkbZuvSraMT4ItUldWkectOmVpewL+xRkHKpMmacAHfoa88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YPkrhXS; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3YPkrhXS"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-509062d829dso733711cf.1
        for <linux-modules@vger.kernel.org>; Mon, 09 Mar 2026 04:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773054944; cv=none;
        d=google.com; s=arc-20240605;
        b=lzdxtmErttDXJX5mqUZiI3YaOsIfsJTEVTshbu0S5LTwcrf4SAfzCL+dTt0lx2o/ck
         qm6wY41ZhzYQv2sMhag2H+V7A/dQVMzjTM0bpgpyXv2cUqSFVChlUtLE3J/6U+JBN6i8
         mSk8tcZw9YB/lbOmYd1syZPjq1yu6AEWvQYlppF18K0johVszGIJlYgxwXOJIZhKp2U0
         I3oWubGOdRdn2j9iEzdLKZYbjxwhJF85JkFEIZrTg732Vm1J9zMvMB5g3XmQdMbDgLUo
         L8FD/PqqSmFobAZDefv+DICMLselO/slpaIUMZuasPe6B2BS+u2Aw+j5JzTTTffhGwE3
         V4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bwnTPQewhTZfBV+DUD3SsbtLeKJPcVZC52nT9OgQfwk=;
        fh=RLYuLSeDiSleqGH9oeVeE6jrqoCVf02L27Owd5p39TU=;
        b=LsvQFKaT72nSZMBxDE1q0w4T47ivbuou82az8+dn4R+8mUTbOxivjAj8t751Dv5/vj
         y/s/xH47GYNpIhcrUm07hRvZDaMGb6YHFMU5zEcQLIBs9Bi4R3dnkxlNyc5+Y+sjb4zG
         DlQBnhsobLDp426dsz6AMhHHe4wJJd5EA6q/NfvxSbsJw12Au9TG2HYtzUwVOFIewnCs
         Rmmmc8hIpZF9L+a0KRI6hbcPzoLUPa8kpcyHMplwGv1YK8INQRlMfxFK9JJjVglLjy4e
         c8KRgumcb+kBuWmueULu/D7jTdVyXQYGvviAFrAhMjpWNVH/VIaL3q2m6jasoBQsYJkR
         wCcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773054944; x=1773659744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwnTPQewhTZfBV+DUD3SsbtLeKJPcVZC52nT9OgQfwk=;
        b=3YPkrhXSm3GaAy9SxVLzdt94rUHSB+eXLPeosRqRxoAI0ep5W6GAZGf/jCY3OQDu+0
         hYlxZV5tvhH7VVEupO4NO1fNUXfhrjtvN7PRNkHGpCZ6AvnLItNROnPtj2Zz0uoPM0D7
         L3jVb7o+GDp1O6Bfa66iiJey97f9aSvu5nEAgTrKA9XKwSU3WdKV7ytrJjNjx8oeL2Da
         pMJbk6J8JAkE1YvwnJC7kTz7yRBcphUudl6qTAm3cTt4d+07QYw/Hq9iYob1sYVmk9n/
         oSKL0UhjCYNTs4l/+7m+Wfwh8e+y2ytopKZ2TCBtCYf7grNtYC9ehkLq0O8CRfeM4kaa
         kZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773054944; x=1773659744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bwnTPQewhTZfBV+DUD3SsbtLeKJPcVZC52nT9OgQfwk=;
        b=eE4+qTBpVd3bt3bGLv4QBvttkFThc09+68gHC2oOaC19+lmTzlFXftJce1H46AlbLe
         L0c7mB3IU32KROisCMhA84zs9JZws6Px9PZhRVqBjY2l02lhGVdPV0c/bMueLj4YINz6
         DY2YFqsKeV3grEELBd6EEgENvc95DsLSWxiFdjngFzXWXmPktXtJCg2M4Ju8VoFYYa3E
         z/cUyapn1BKmpXHHnEN3pDz9wF7TUAHsIOjUssPlUARbEi6VAKTDxZ+oe0rfcUhlf9Yw
         CzAamlwehHdRhGN8UxANiHyVSA7CL5ByIoUrdRf7WkvxRCiPmfHwx4Walu7lwc9miEkK
         vNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwekjjxTR+B+Av7LnKkslY8XLjjbC2c9pJeBXmeUoQ5wzwIT3mOQaFMqZO2UTbqZJJ3BOeZ5pPLj+Rm0RR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ap1osP8Cz8TwsCk6gvyRjYQusKPS4F2LCtdfAvVtruGk+3ZR
	LAS+FrU4+H9/L3PVtvk77TXyqX3hyPutQyFMCy6UyUrgdxv+mSB0tTVqY6tBoT9qeDHXRwq4+3h
	IquqIK76i7fRJxBvQh9nHdINmFrBemlnQ71aoq4sx
X-Gm-Gg: ATEYQzwgUMMvjMcDqec0QMYpCJpCSw7IrPUjRk+mRwa0f1ZNpmF13Q08zF+iN4vUvfr
	KoA+/xkwi0ECuQJ3b++CVJ1PFP1E/ph0jweNKnAbqJCEZySbPU+JMXewIVg4pGDVKmq543ZAVrB
	izekK5e/uoBhfgN53GptDMOR9xlfNl4FlNhCGbp8jHIBISCJ0TiRf4h4ERNLbIznzvTc5XzJjEq
	NhEASv84neATf6/Gp0xFNWKTEKR+nRo3xnWKTUvUQx3am93AHmzj7PL7vQtAkMJcOpz18s1qXms
	J/zDUxOrccJdAB1KSUYshAlR7i0Z5XQfohXuTHn8Qw==
X-Received: by 2002:a05:622a:309:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-50900fa7fa4mr22518531cf.12.1773054943674; Mon, 09 Mar 2026
 04:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307090010.20828-1-linux@opensource.nslick.com>
 <20260307090010.20828-2-linux@opensource.nslick.com> <20260307093006.GU606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260307093006.GU606826@noisy.programming.kicks-ass.net>
From: =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>
Date: Mon, 9 Mar 2026 11:15:27 +0000
X-Gm-Features: AaiRm537s3HnYYKX-9TgG4VRgrwS-5joKWrN8ricsEVy1qLcUU_sUcpVi_zjyDg
Message-ID: <CAJFNNnoweqzaTn6GVb2L7dpvnby7Zi0je25hVbQHXS_kX2O08g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] module: expose imported namespaces via sysfs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Sielicki <linux@opensource.nslick.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-modules@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 9:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Sat, Mar 07, 2026 at 03:00:09AM -0600, Nicholas Sielicki wrote:
> > Previously, the only way for userspace to inspect the symbol
> > namespaces a module imports is to locate the .ko on disk and invoke
> > modinfo(8) to decompress/parse the metadata. The kernel validated
> > namespaces at load time, but it was otherwise discarded.
> >
> > Add /sys/module/*/import_ns to expose imported namespaces for
> > currently loaded modules. The file contains one namespace per line and
> > only exists for modules that import at least one namespace.
>
> What I'm missing here is why users would care about this?

FWIW, we use a symbol namespace in Android (GKI) [1] for symbols that
should not be used by all drivers (e.g. direct file system access).
This change would make it much easier to surface at runtime, which
drivers are using which namespace and thus have access to symbols they
should not.

Cheers,
Matthias

[1] https://android.googlesource.com/kernel/common/+/a38b207d4f4e02041f72a8=
168bb24d1617099988
