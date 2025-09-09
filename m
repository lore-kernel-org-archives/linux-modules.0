Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60605350D6A
	for <linux-modules@vger.kernel.org>; Tue,  9 Sep 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430223; cv=none; b=Du/ExnI9ddyeT94asuangE9wm/PhMUcTLzdWins+kYZU38DqIdllsEzVYZ7/UvTtdTMp0qZw0V2VNHnQxAxrpB3QMNWLwhmku0IsooWnGzODLmbc8htK4fySHpZ+qU+KjgGdeMet7JCn/CXSB4YqdX1lZYQPh9Ck09L2zBtgu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430223; c=relaxed/simple;
	bh=s2eOuFXnk4JEiosXfEmmNMiAHYoyrWK0QGfId2hIEv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8YkLH8OqOlNHlmu7oRc+dbRnInrsaE9krODIW8J+Mn5LaD6cvNd+cyEeFA9Gvdh41lPoL+X5eqzM/ePILKHNOGJfthZYqrcWL2DpfJQVtUv3Y3ZqAzzuSpzuJtM8FgMUYRktkPRfhuka/40vdQAqQbYhg6NWRgWVD3ISKKDyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E68h6YW7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E68h6YW7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-336bbcebca9so43113631fa.1
        for <linux-modules@vger.kernel.org>; Tue, 09 Sep 2025 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757430219; x=1758035019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2eOuFXnk4JEiosXfEmmNMiAHYoyrWK0QGfId2hIEv0=;
        b=E68h6YW7+KTZBCHDJqe2/6a1rAOw+MsGwXSE1sYM8xX9vNA0ZndSQPZgxgYLDW1YPb
         yi51Y8MxmLHY1W5EGii7BxNhm0Fj9GUPZZfjEyHmodOR0hIhGKYdl7SGWjzWwI1uRWjz
         MAwzwhPjUKR1YmhVZ1wjysWkHy5ngeP5DIuAoqpu5h/KDvI9jBt9mHSmxT2AMXP7z5nh
         KUPIZ5AfcQr/oBlx8cR0n6a7H0fGSnoXejteuU8Xa0LrBWsNbvVx5+kVknna5A6RcgBu
         hLNoYIrrd8gsNNduAXaRTQaR7MK+Aot9tHmUYqP7XNs6Tnogi4Lnx8CZxJEMMkm0Ligy
         txTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430219; x=1758035019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2eOuFXnk4JEiosXfEmmNMiAHYoyrWK0QGfId2hIEv0=;
        b=BK89jmQb4lTgCMc6F/VG+xYLrpWl54l8i6l5Va1hrhdAe4Qo379wNoxNGeMoACJHT3
         MEi5LxWejegidUmW7veA4nSrbJx5orCBevxGC9qHXWBDfvf4549ZTTbHXIrIL8I3gOVr
         zKCQVOfgN+8E1kHFDA9QPgpvPhMx5fye4PvuEwwIqd8JOI62x+3mRB6INLzvuz28tp5o
         bAeV+4wmI+VTBgwGVjrTdXyA4qZ9spJfuEvcmQuf4geUnv4YkJ4/m+nYtYaVUDlZP//h
         dhIfRubPC8RaPY4sqKcH6o6Mj2/gx/DdGghZ9giz5OGuxFLNYl/1hzlnDLRzj8UX7W3d
         0gqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjBa6dNMaq1JKmOuPhi61A4xT8DIN3m91y62IcGt9XdrfiYmCHXxV9ab+PA/lT2s2ipC5EL4EdZC3t0xxM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1Y2eeH6HgCN8YCelQvqgOfBeP9a1M3yRTwl6GTa5kxkD9fjk
	TnO2HZio8UZhYC8/SO8okeK78SQlYV5HBuDKuRy7d1nfYENvhiXCq56s7I6mUMWjKX18n09bTDg
	S98zD9VHCQh16qtKFiYk2oyBDjdGJfoU74cIidf9+4A==
X-Gm-Gg: ASbGncsw+0XZTdIHm6nQ04UeIZ94UGqYSZNxDn0xBs2LSrrAZCy6Xe5HR0lKz2soKoK
	UrTeH7rw8fmpAa4WCrdO0ahhM55TK4VnCXxzXBd0UJ/8W3GYhuiLYTuHZIIbuaJqLnvB+cbCih1
	Ns1l8cD6eDsjRSl1q8OaF/HT6Ga96E7UipfEUGSssBqmF6ZU3dhevbX0WAVOHYnYrxff8Xt7HSC
	MrFTUnMSxHgmc0d7NyG7SzyHNA3I7F3TdFqW7rDVKcbFd+TaW8=
X-Google-Smtp-Source: AGHT+IFtHjCXW/IC9j6GEwjcF/4gyccj2LPR8G94RV0BH7HbnXztEbz95W8S/ObWmv6rhWZ8btdWEU414oiNIQRprWI=
X-Received: by 2002:a05:651c:b12:b0:336:dd88:69e0 with SMTP id
 38308e7fff4ca-33b57c39f8cmr33976541fa.29.1757430217780; Tue, 09 Sep 2025
 08:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090130.101724-1-marco.crivellari@suse.com>
 <20250905090130.101724-2-marco.crivellari@suse.com> <3e007a66-419d-4933-942e-4e5cdfb06887@suse.com>
In-Reply-To: <3e007a66-419d-4933-942e-4e5cdfb06887@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 17:03:26 +0200
X-Gm-Features: Ac12FXwvtgAzWLuGL3iHfQ_lIqD5ZbleIVuFHOnTDiKTdfJQEhR8WxsPlf8W5bM
Message-ID: <CAAofZF5rA1VKDDNUYrxu=i6i81iLBa0GNOUCrQbUMAjZxrxmiA@mail.gmail.com>
Subject: Re: [PATCH 1/1] module: replace use of system_wq with system_percpu_wq
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:37=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:

Hi Petr,

> If I understand the cover letter and its linked discussion correctly,
> the aim is to eventually move users to unbound workqueues unless they
> really need to use per-CPU workqueues.

Yes, correct. This first round is just a 1:1 conversion keeping the
old behavior.
But later yes, the aim is to let per-cpu just who needs to be per-cpu.

> The two work items queued by the dups.c code can run anywhere. I don't
> see a reason why they need to be bound to a specific CPU.

> If it helps, I believe you can already update this code to use the new
> system_dfl_wq.

Cool, I will send the v2 converting directly from system_wq to system_dfl_w=
q.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com
