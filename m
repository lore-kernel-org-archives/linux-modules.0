Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FD31B826
	for <linux-modules@vger.kernel.org>; Fri,  5 Sep 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084982; cv=none; b=jr3h1BBhx/StFtPutG/Y1AWbQSQEL3L+dqvL7UkIFS4Wbk0VvHFkNep3VNiuKJquv3xl1aoXI95xX4dG7jgV1XUD9fWkoPJ5xZKKTHHhow1LqOeS/chjluoX4irsSc7Zf/gKk/Qld34KUmoS2ArYECw6cAGcqpMPqwn4nkTQW8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084982; c=relaxed/simple;
	bh=dFdVomeaxD4LPhyoEmMyXlkg6qCcKVW87KQws4WwyuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkIpkGuXCzyIjE31c4bSDgWL0ZQoftY4VK1nbg4z5knDqxs5MQ8HFQ0B7CRjkTru/Ggo84LZRHqLMt5wlGmqso3ZFpW4F05l7PuNd2znFQaRQU85Q4TyNEuhteG6sD+/JksSglXRmdgkgHIn4tlc79pVBQ2ImZFujSjqajPZyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8/t02kD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8/t02kD"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24b2337d1bfso194975ad.0
        for <linux-modules@vger.kernel.org>; Fri, 05 Sep 2025 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757084980; x=1757689780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFdVomeaxD4LPhyoEmMyXlkg6qCcKVW87KQws4WwyuE=;
        b=I8/t02kDYls1rrpwAmxAWi8JdyOA4wccts+YEjFZuyf0FJ/84NJzq1V5B+h3agBL9f
         R5Xjpw9MNrNYzFmdYjQwQfoHm9F13dfHursuLcEOkazXJkOsDNdOutrTFpfsHAJaD7dg
         N1C4cpKAVeuP079/xWoZuAOXagGIKuAk/V6sGZ1Qy98X1X3hpNMUoB6EDHc//YkS4U1S
         yr4qx6RdNWouDWSTwtrUpU5E7/8S1aZ+2JLYUqLAt56BPbhyHOkaQhCFbZuQT7tx7eBn
         QQ2vtqFUxwoD07rCA+a8/3oe/s+p6/bpep3L5M51vsQ0KAlZ9Y3/VaWlhiCI79YSCPZT
         uLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757084980; x=1757689780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFdVomeaxD4LPhyoEmMyXlkg6qCcKVW87KQws4WwyuE=;
        b=QxYydNiRm8x7gS35hqFcFjKaGiwFGanHS5gUgaPin7cuZG5Ae5b+R6bx0f2CCJM3wg
         gzvQ0ikH4rFeOprsRQ8j/qbhd5XhxYl9A64dwxEVVyOILoWt1JINvgwAmOjBWp1+7co4
         NEZUyXkJApjv033vov224ahu34zVmVcRsE4DDkI21mJuvuZ5Xg1LPF5LBWlNq9qn7ZnA
         +aa1kM3kDuoLNXqnWLoCp67e73gZr8sK3j1cnxuVbWuZqg5H5Ijm9njrQHIs2I2GyKmM
         cmdtp5cY8JEF9xckstZ2gGUMUu9IJ/nArPd2os2Yl5VkzdCutOiLPPGaR20G556P2BSs
         BJyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9C1LWBLSWO1D4chg2/sSvvxhm6HPGsCkugAoavksL6i2yEgeBcxl+S2t13xxu2rBEJtvryJ7/DIcIZDMD@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOQ+PTsopYOREWoIyDvAQj/L1u6zMwIK00UZ0M3B/PaZ0fZIV
	f9zswXy9csvqAfZ7WOdK7S3Y0kj19PkA+kkN/pjgHyjdNOlJ3Cp5VsUzHpUmi4vcDQdiGzVqbbA
	fO6ODI/EJBOrMnhwsQfJYgVYbvc7q27CzLypSjLD4
X-Gm-Gg: ASbGncuKMtEfyNZnljpREG3yuQRq5TrJXghkonV2oR0lbbSZ6Ys0NLKfx0O/4motEVL
	Iei60AtsAXEXLpJFPQ1B9ZNRNmuYSc/lQ+qwnk7QRp4LtAaUs9qPUOoQxuXkQ3mgUEJaOeRfSO0
	hBJva+C2VZKf2IaRVrt0S0nn1rmYjwLqj2SdrTNSYjVWh3M3WFpFA3ClUgSaGSs6W1k7LAAKLyY
	i0/Q7sygr3CdwPTmAxVOzVphzBEsmPK
X-Google-Smtp-Source: AGHT+IFigRlugHFu64XYH5E1HhI8NlSyNuAc3Xp90gTVTmK4u8CmaCMLRItGgVFLK1yt7YLP9pFW/NA0U37fFcFhCUQ=
X-Received: by 2002:a17:903:2f85:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-24cf5c29233mr4503325ad.8.1757084979941; Fri, 05 Sep 2025
 08:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a40e660e-5a45-420a-8d37-51324242ab9b@kzalloc.com>
In-Reply-To: <a40e660e-5a45-420a-8d37-51324242ab9b@kzalloc.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 5 Sep 2025 08:09:02 -0700
X-Gm-Features: Ac12FXwsBG___TZgBCnwrUiXvtQzs6bTFvY2gqQx0WiC1kXwGKAPta7iWLhYPhc
Message-ID: <CABCJKufSRmYnbjcwvhuGgC=xkyPgJyi7FMrAdDm3N0fun1cLAg@mail.gmail.com>
Subject: Re: [Question] Non-usage of PKEY_ID_PGP and PKEY_ID_X509 in module signing
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, 
	"Sami Tolvanen <samitolvanen@google.com> David Howells" <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 26, 2025 at 11:58=E2=80=AFAM Yunseong Kim <ysk@kzalloc.com> wro=
te:
>
> Given that the module signature infrastructure seems hardcoded to use
> PKCS#7, could anyone clarify if PKEY_ID_PGP and PKEY_ID_X509 are used
> elsewhere in the kernel? Are they perhaps placeholders for future
> implementations or remnants of past ones?

If you search LKML archives, you'll find some past efforts to add PGP
signing support at least. The patches never ended up being merged
though. See the discussion here, for example:

https://lore.kernel.org/lkml/20220111180318.591029-1-roberto.sassu@huawei.c=
om/

> If they are indeed unused and there are no plans to support them, would
> a patch to clean up these unused enum values be welcome? Or is there
> another reason for keeping them?

Perhaps the folks involved back then can chime in, but I'm fine with
removing these. I'm not sure how likely it is, but if someone at some
point makes a compelling case for supporting other key and signature
types, I'm sure they can add back the constants too.

Sami
