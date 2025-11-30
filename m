Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85922759C
	for <linux-modules@vger.kernel.org>; Sun, 30 Nov 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764527268; cv=none; b=XRtRLC3pyVJrzBwRJPFMqfjhZocErw2az30KeSql75/+46Z9P6XcDZVtek854pGg09iZDvhNQzQq0iK9rIIDP5Ue+QQZkoUFX48ii1RPdnt9tA+YGXHvSuhdvTEZYaz/7IlzFz7YGOAR8uAHUECWQSW+ZW1juuOnjHCshUPkqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764527268; c=relaxed/simple;
	bh=jKo9YN5Ow3alHkdznaL+oI7OWz6x1PeXbTSgFh2nelk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvK64YcGb8nTlODRmZa2Zv1I3g+L9ihb3o2x2zwcn9++kEzrmJ7Tzp7h1fWZg5tlqiJDekQd1dy5pC9Gx6dzMg9E9RRnaVxxpuBojYC+LQ5GnyOIJXg9G3pd2bgNTYB3aqLMP5VPd41pF23pn9C5hsQXS6Z6RUs9ysz+YjuXcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im7wLo2F; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im7wLo2F"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6420c0cf4abso3140085d50.1
        for <linux-modules@vger.kernel.org>; Sun, 30 Nov 2025 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764527266; x=1765132066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ0UOimIv+Gqhv0/1FQc2e2rNrHodQEz9DgOtiLMoSM=;
        b=Im7wLo2FZbDWvS57VeZXCNKGBWg86nCdPDi/2/GeVpjeefW4iNjd9zObOS5o6ecsE4
         g3VQYRGCDfYBkc3SMM2dsQgdeHDGljmIW0e0PlAJTs3fss+h6+DJFdSdEeRArMGvmspr
         9ag76j3uB+r6vAmH0Nf3iOc4dw1rNw8SEQO1B//vrtRIshYnX51aYTmY/qHY2cXFsVTC
         EHFhp0RtjNU3TOZpR7KeVepVUOhhdl8atkjav0RmQKYytJMABfsY91HP6pRwR6FUsNjj
         O1TGmyyfVkeUUA+nZgMntSHG9PXqJ3k0KN60JBxm7cXkYZzwxwMUiv/HfQ+zYqK6X4C/
         uTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764527266; x=1765132066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQ0UOimIv+Gqhv0/1FQc2e2rNrHodQEz9DgOtiLMoSM=;
        b=SjxBxwBzC+Y9aBxGFbk3HKYC87iWXmm+5NNiFuPjjsRDgRrfZRZ5yEq59h38mOZvGk
         +6NAuPgoL9fdUtll3/6xK1v4MuMmfknIR3h0ZWqYy9MTl23aeexLJgS59jsHrPNxCFHL
         XZaQBPZ6HpZwzsvCe/ioWfYjaFq+kKxbegyiN8N/R7+jBZbzn3MMNgxNMh5Bcbx1PI1A
         +R7Wgf68Pah9Lm66B1DisIze5sqt8hp3Jp7o/6//Z5Dbpa1Ye2XqUG9eXaqMoalv4fQM
         ErXPUdp8aH3bLQ1KebLRJoi5DJlQFwnDlt26iC79/RrucXAWxpyiW/BywztyMI7T1q5b
         Tcvg==
X-Forwarded-Encrypted: i=1; AJvYcCUfqG7Zv/8FBOC7c1ju2nMkBXMUYclXVLxcCS2IlnMcPj7dB9Ut4sWfuUO+K8NFCdySSGlBiMrRXAvRHXl5@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFb3mHPuIxQ5m2/LWKL4EJfQl5ziNKjbmnhO3ar+k5dmjOZhI
	JUQFU3ugkzT1gs6XNPTVXNOQTPUTSUsrHk4him89g+P2/KqBMoRquHu3
X-Gm-Gg: ASbGnctkDR17f68kRcVg3WIdwPmXkuZjauUuvft1h5kaE6FSnik1NoAoG68aMJwWVxX
	lSTl/jJqyQt8rf8RNW1h2n6ppfgKraLITrLj8gX3kIgk3Y3V4cHsfsQz8xn/vieqQ5zueaADM0I
	7s5U3Ne01OvcaTExS4mbFV9r29fHBrPe+hIXESILMFoVBTjWbNnmNta63MnxMJgQvfVBk8m+MQz
	wAuF0j0lbzXPOcKUre7ChnavNw/wwfbEDBBj5kIh0wnEK23d0jJfqUCb2OtK2PSrcUTrnOanuKp
	idFoRfgHDPgMDXULs1IzOWdQa1CppDM/2p899rlGdjYQmfZIbmVFmx8pt/8UwywL6mryJdFDvr2
	oED3E/qyaXNMjbmUCJLln/juLG891w1s8N+1pMtTo2Ab8CFBoQJPgtxa7DMOOElqquxR28efhKt
	NWP8czxWI=
X-Google-Smtp-Source: AGHT+IFDyYOeUhT8Bbb9GCbxFDItrQuSs7u5k0phj03PaXnRWntIOvKeCN52kZaBXAUM/+2zDMUHvw==
X-Received: by 2002:a53:b2f5:0:b0:63e:1ca0:be73 with SMTP id 956f58d0204a3-64302ac3594mr20527544d50.37.1764527265793;
        Sun, 30 Nov 2025 10:27:45 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:b42b:4ad9:10af:cabc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1011c00sm39418837b3.33.2025.11.30.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:27:45 -0800 (PST)
Date: Sun, 30 Nov 2025 13:27:45 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Message-ID: <aSyMobJnY4qKmsdk@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-3-yury.norov@gmail.com>
 <aStWkK6exUj9YEC1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aStWkK6exUj9YEC1@smile.fi.intel.com>

On Sat, Nov 29, 2025 at 10:24:48PM +0200, Andy Shevchenko wrote:
> On Sat, Nov 29, 2025 at 02:53:01PM -0500, Yury Norov (NVIDIA) wrote:
> > The macro is related to sysfs, but is defined in kernel.h. Move it to
> > the proper header, and unload the generic kernel.h.
> 
> Tough guy :-)
> I hope it builds well in your case.
> 
> FWIW,
> https://lore.kernel.org/lkml/20220603172101.49950-1-andriy.shevchenko@linux.intel.com/
> https://lore.kernel.org/lkml/20240212115500.2078463-1-max.kellermann@ionos.com/
> https://lore.kernel.org/lkml/20240215093646.3265823-1-max.kellermann@ionos.com/

Oh, OK. Surely I didn't want to undercut your or Max's work. Do you
know why it wasn't merged in 2022 and 2024?
 
> Assuming it builds in allmodconfig, allyesconfig on x86_32/64 and arm/64
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It seemingly builds well. Thanks for review.
