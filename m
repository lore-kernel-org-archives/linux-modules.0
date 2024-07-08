Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616351419B5
	for <linux-modules@vger.kernel.org>; Mon,  8 Jul 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450689; cv=none; b=GFCuDbYlQSqBR9MTbK++LAUA4xQNvYWceC6tZi6T+wu1lnl6BKypuyD4wcn8gOKImDfPbfH3/+uyNrrmbvIC7kJMr+UpVlkxZ3tNuzeqF3wsPYFc7Ur6Qjemr9aSLCkglmET2wuhPQAV2ylXugH4bJuy33oagl7kQCaLqtBSKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450689; c=relaxed/simple;
	bh=MDeNvHameo9rL2F1OO0TIRvyNCXSMrYbT2Z7XXBH11g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKpj9IYxmWYSufHpS4Dj67BEn2CG3y1Nwlna32PqXzeum/IK+aaq4l/zBc0LReYHW9yZ/ASQlMcuQtfsQkh/Pbj948SprdFwyd5ANw2GgWAONvKEzFga/DuXeXYfVlY4vaTT0BHXlr9Dmsc4s+T8aMJmsALJLL+7MU70AsnDje8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhbrt7Ez; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhbrt7Ez"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367993463b8so2891903f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720450686; x=1721055486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzKAos6I+LdBzCnqLAKx0gau6C8n/uwe2FwnMdtyzA8=;
        b=Bhbrt7EzoKT5oXaWE2bVb5eEyqYWc3rXZJnPzo0Pz0nkN9q6vZZ79jBmTzOHDTAAXo
         MghEnTIm/vcbVLIbVmNaiJuhf9pJcXdESTD7H0qThNdwE7UoZRTRb4Vl/p9lhWTNs8ie
         gavwm5bAH3KLEdyluzv1eWrEIvGKOZdpF2bPCq57WFBD6DR2X4jjOT+YqnYiWup/wyND
         vnfLg4N+SlB92iI5u90GYl9POMxdkWG3qfPCQFdT8x3qeiqWp61kzYmKcjJ+e2028Y/F
         OA193dck3ERNCE453w0kFfx2VNAZvv2BLn9R87LtdJgmZQEwyMpdEz/LeaPZOE0wXvwm
         A4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720450686; x=1721055486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzKAos6I+LdBzCnqLAKx0gau6C8n/uwe2FwnMdtyzA8=;
        b=CRBDPFU5zIRpLNPUQuNIfCViq8KdTXhPjDZjVCv3x1nda01GEiPXFYJt5dQZp6nbJY
         GlB6m11bbnW6ystt8XEGjk1AjvOEA185fDWM8Mz4A7dHeITETL7qOpJBwbst3/NRPj+C
         x+33wEdstZgdO54EHvo5UoODUe35yGlYKbDWSzhFeNKyD4f2nVvPSnG76WefMRiBs/J6
         Z8/5rokHljIzUodzC0lzJEoL8lNXdcwWGt64R7bvQpdlKnPZxeb1h1mwIBOYsq1w2xwV
         Ctz9+ew9MWSV05LG0KdeDiFgY7HC9Sv95KGR5iDxjCJZdBhbpt5xNahsp0lganJ4/q9n
         2gdw==
X-Forwarded-Encrypted: i=1; AJvYcCVFdKk3GfL7u5c5rgjP9xsrYIctisthAyPtf3TXH4iGuotZwVRkgvctB7wG3eQuGdox9eFNurssru+T9nF2sTCEIs0uPa/AmzKYGDpP5w==
X-Gm-Message-State: AOJu0YwcyYn73ZwWGERsX2TR7UMNztZJ6eJD4JVHP75H3B7JcZCW5WlX
	v7Yi1sB1Hxdo5FrQ8nOfSLQpg122rdsxiz5JayDCyRm4ByAGrUjL
X-Google-Smtp-Source: AGHT+IGGKmgWdfWkUZ/15GrvAxFrFFlQd3kEkTlfSM9vMBMxYFVaMr0gfeSh3B8gYmHQXLgiChATyA==
X-Received: by 2002:adf:f3c2:0:b0:364:348:9170 with SMTP id ffacd0b85a97d-3679dd63d98mr8647028f8f.54.1720450685488;
        Mon, 08 Jul 2024 07:58:05 -0700 (PDT)
Received: from arch-x395 (cpc92320-cmbg19-2-0-cust3522.5-4.cable.virginm.net. [82.13.77.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367961a507csm13357103f8f.77.2024.07.08.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:58:04 -0700 (PDT)
Date: Mon, 8 Jul 2024 15:58:03 +0100
From: Emil Velikov <emil.l.velikov@gmail.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: lucas.demarchi@intel.com, linux-modules@vger.kernel.org
Subject: Re: [PATCH kmod] testsuite: add tests for weak dependencies
Message-ID: <Zov-e-a_KQyJb8LI@arch-x395>
References: <20240530070836.9438-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530070836.9438-1-jtornosm@redhat.com>

Hello Jose,

On 2024/05/30, Jose Ignacio Tornos Martinez wrote:
> The following tests to verify weak dependencies have been implemented:
> 1) modprobe test to check that related weakdep modules are not loaded
>    due to being a weakdep.
> 2) depmod test to check weakdep output.
> 3) user test to check that configuration files with weakdep are parsed
>    correctly and related weakdep modules can be read correctly from user
>    applications.
> 
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---

Seems like this commit has regressed make distcheck on my end. Namely
I'm running the following commands:

git clone ...
cd kmod
git clean -fxd
./autogen.sh c
make distcheck

Result in:

...
make[5]: *** No rule to make target '.../kmod-32/_build/sub/testsuite/module-playground/mod-weakdep.o', needed by '.../kmod-32/_build/sub/testsuite/module-playground/mod-weakdep.mod'.  Stop.
make[4]: *** [Makefile:1903: .../kmod-32/_build/sub/testsuite/module-playground] Error 2


Can you reproduce it on your end?


While in the area, a couple of question if I may:

- Should we move the new weakdeps API in libkmod/libkmod.sym near the
  end in a separate LIBKMOD_XX section?

As-is, it looks like we're adding symbols to what should be a frozen set
(aka LIBKMOD_5, which was released decade+ ago).

Admittedly there was a similar erroneous(?) change not loo long ago -
9becaae ("libkmod: Add lookup from module name").

@Lucas can/should we fix the kmod_module_new_from_name_lookup symbol in
the version script?


- Is this work related to the weak-modules used in RHEL/Fedora [1]?
  Alternatively, would the RedHat team consider having the weak-modules
  solution in upstream kmod?

... assuming Lucas is OK with the idea. I'm approaching with with my
dkms co-maintainer hat on, where the fewer "if distro == X" logic we
have the better.

Thanks in advance,
Emil

[1] https://src.fedoraproject.org/rpms/kmod/blob/rawhide/f/weak-modules
