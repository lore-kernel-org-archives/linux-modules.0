Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0102525A8F
	for <linux-modules@vger.kernel.org>; Mon,  7 Sep 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811209; cv=none; b=o/FoeyLg3qXpd7QDTWluWmDcGmcPiVmUv7yZQvmCU87+YN1IUESouWqugWMXho4H08Bez0caqEPkThJvTvx2FE6HqifkbHLeE1ldJ926EsOb5uz/NdS32WiE06XVkmvyOaMp9DUQs4aAv32B7X2JydBBWL39LasJYWj8rOBcBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811209; c=relaxed/simple;
	bh=VrloMq6OScCabj9CKR02TTL5qYLUYZi7CQaAXNRhI1E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YkMiIjt1RtRHo0+nz9F0iDmIwwKoNYn9T8rsfid9af1Oka9i5by9d3wnpo4odiSOQdLEVGL/kUaK6Bg4o1GcOTQ2xU8Fzf1asawzdtcw+/18MapTqTjo63Vg/m2IQCCGW8pOoxN205rQPZxKLBrIGDoEyDXAj2LWCBHgWB+ibA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCcN+/Ob; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCcN+/Ob"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7f4f1354076so91481a34.1
        for <linux-modules@vger.kernel.org>; Mon, 07 Sep 2026 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788811207; x=1789416007; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VrloMq6OScCabj9CKR02TTL5qYLUYZi7CQaAXNRhI1E=;
        b=iCcN+/ObXz531fUsXfUTPPSqjSO+s2oBLOj3Q2CrU2tumX0Xf56NmRv5WYVLFdf23n
         J+TpojFzOzH+WAjU4kG4AELO4A+kw3H7a6wk1AoBFf4kp+WxAOg4MqD2qHdZ6rdsct0L
         EWyN4s86EfUz8i33nuvT1pXp1i+H0ncQcVC8F1Qc8rXSH4hqhYfGC2GMFvYNr0Ck4Z2y
         SS+kvjU3Qn7hnI304ao2TbFciq6MDk51TG3Z6RezFQCg4J3bvd+hZCqlHYnVEknKr+Eq
         qGj3yGl57KBYgUeAONB73bDe0SCLWgXxjTjOXPy18P6SZrNl+5qGg+x5t1EwE3EHo3iX
         dSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788811207; x=1789416007;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrloMq6OScCabj9CKR02TTL5qYLUYZi7CQaAXNRhI1E=;
        b=BihXdHyf/0fiHKNcvaUOlV68nq0z4+hcyCatkR3Hkse2wgEMTBQ8u+43yUa50PSLUL
         g9fNe3WhU8uAJGdZESUZl2KdKBMwhaINwTvzuweY75GUdfh74JNe5akNDlErlluA4NDs
         9yegRQ1xSIdiVnU9gRkxSfaHjOhcpmVbH98BJG/VpbpwXGgCxMa/QY22gijRCvAEffqf
         f6DnmsZV1llNXnYWLrUQ8wsS9ZZilOq/npy2l3USlVI1v/5UhqbL/68X9Xd5+5Gi7MbF
         FIHMM7+7OX/NAX0Kh6nrAN4zE+K64mehetLKmQTq4wUbYxuCZJLx4oC2SH3cn71L8dwx
         rq9A==
X-Forwarded-Encrypted: i=1; AKwUvBxfEbAVjYjxiatIqYWgVQxzFnNUrpumeZOwAipaql/sqdpn8Fxtxg5VsgDGTqOoYBfJqlyxUMEf48WWGig8@vger.kernel.org
X-Gm-Message-State: AFuF++loZmlCn1d4STAziSb5sTDG4VBnwMz8quoUaAtSRiqnKJiC03GI
	ZVwuFwMv5JfgEwPjbR+Y9romNCakZehRUThSu7p8PrGDI6yWXa2b6k9c
X-Gm-Gg: AYBFou3EpyYkAEsk/H9/VORjCzAWUO3Vlh+fvwVbuq1bgJH2jp7lDc7w4xAhLYVbh9l
	qBjJ/GiafjDeYEHuZPNfnFqYRhIRE5/CWxH6hD9pD5ghxcVBHSqRMrCdo2QBhvq/2DWyRMFhRS0
	aQclJKMpS1d8KfMghZePgMUlk5cxvUJ7i+TEZK+IO2ZZtkkTYDvtYO65XsA4lVzfGNkp6zxspAg
	PNYBmkdkkh/T/eH+puxJ6NwNXwZiEAgp2XbJXckczbhyiTAgNRrN3aZjP1d1sUMfevHXL532f6G
	wGYRyE7/fQceDGoTtkIOVFjuwz43NI01IPdwbR/eiGwx8yvCINoz5JoZcKt5YxpVMVKLrS+pS/I
	tllge/LqsCAKN2aaK0+ndovOUc9VxjfWy16J5eDyThiEemPuJet13iG1ZrFefkMuUJA6m2cnczF
	FxmijS+kH+AJXPYLh6O86PhLGATyK2l1r0qqHEUu2CEx2vraogr/IdRbLrH03rxggC+Kk1erWhY
	LN7QcMVkEIW7MQKrXt32oGjEsMMmvtAlzBapMtaCYzhhNoLQQhi46s=
X-Received: by 2002:a05:6820:2d0b:b0:6b5:ec3f:4986 with SMTP id 006d021491bc7-6bc27defb7bmr822289eaf.33.1788811206610;
        Mon, 07 Sep 2026 13:00:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dbedc6fasm14069610eaf.3.2026.09.07.13.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 13:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 13:00:02 -0700
Message-Id: <DL9CNDXUNKBZ.4ZPP6WKB4BPM@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <ast@kernel.org>,
 <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <eddyz87@gmail.com>, <jolsa@kernel.org>,
 <ihor.solodrai@linux.dev>, <yonghong.song@linux.dev>, <song@kernel.org>,
 <qmo@kernel.org>, <martin.lau@linux.dev>, <memxor@gmail.com>,
 <emil@etsalapatis.com>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
 <tj@kernel.org>, <kees@kernel.org>, <bpf@vger.kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <arnd@arndb.de>,
 <puranjay@kernel.org>, <yatsenko@meta.com>, <atenart@kernel.org>,
 <ojeda@kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 14/18] btf: Make vmlinux, module inline info
 available in /sys/kernel/btf
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-15-alan.maguire@oracle.com>
 <DL9C40S8FVWA.2T4J5Y8BSF7KU@gmail.com>
 <932ffcdb-69d8-46a6-924c-4bb8fde7b6b0@oracle.com>
In-Reply-To: <932ffcdb-69d8-46a6-924c-4bb8fde7b6b0@oracle.com>

On Mon Sep 7, 2026 at 12:50 PM PDT, Alan Maguire wrote:
>
> Sure; what do you think about splitting into 2 series, with
> pahole support landing once the first series does (so we=20
> have libbpf support for the inline APIs)?
>
> patches 1-11: support for inline info across UAPI, kernel, libbpf, bpftoo=
l
> and tests
>
> patches 12- 18 kbuild support, sysfs availability

ahh, so you need libbpf support first to use it from pahole?
Sure then.

