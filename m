Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848D4D9FB
	for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776148; cv=none; b=X/9tGVYGMlbYm7UqAYXdQeANDR4zs4cZWiXoE3+10Oevi70g7VuRplneED6+clOiB9N5ByHbOW1/dS8q6E9P4CKDBUhxdI0nuLaImJJdBoJjrVH8GvmnEQGcz/ZPyxeoXRgptuu8MnUYzA/vwz+GbPtLelhkuypIwsu4TuJDuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776148; c=relaxed/simple;
	bh=CZGD9Yki2FLQHsFid9OfPienmBqYjhNh+fd/Uf+R608=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKnQW8vLIPTrSUCV17ZK/703b2o1Yieuhqpz+f1JYYtQBHsb8vBrAUTF5mVi80/vm9gpoHTFVod20x7MVL1k+42+ccSHu/ARb20aB5zixxXQuPi7keM1W0qux7uizTzciK5LN7CJVDXaI8JsvXRNfVIdlkLJhzGK/ewo2195ZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kmLPptxY; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmLPptxY"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363b8429f03so10644825ab.1
        for <linux-modules@vger.kernel.org>; Mon, 12 Feb 2024 14:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776145; x=1708380945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrm2VgfWvTQwh4Ccc8xLBpbBJbaIpSksAyHKgKxPeQ0=;
        b=kmLPptxYdBwYxwpb60ki+XnK2fQdCg786cIAoBMKDs1dkxmXXEFlH7jY9t9bZjSy84
         XUUx8HflKy8Qknk6+2Nrxy5JPrq6z5Swu+Tscwp6YaykgGAU9pInkaQlyxjqY2spPsvd
         Oe/1qIv29tawL62wHhQIfc3I06DOR2/qKi28c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776145; x=1708380945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrm2VgfWvTQwh4Ccc8xLBpbBJbaIpSksAyHKgKxPeQ0=;
        b=EUzauspu2U2quFAjmixPU/fgkQGBcHREqlFdaVNGfBuesxsBAzwbFPlQs/20jNPWua
         B7zj4WuNE2YHDvhpc2GxvOBtzi+cPhLjooXpeEFZHQ2tyVE577XJtr1I2G1VOwmF2RtB
         NdbewA4xV5LnOOu4eusrwNIc4W2S1Vc97wzW9/G0bdLS9b8AF79IL59T+DIfsxjplqOL
         Diq+TyBdT/q9jdWcrlF49qCGA/jizpkZl2VK9vfMk0zQQ06nVOjouf86m7HAzT39SHkx
         dh2BP9nI6oPZjWNGFfoPXgsV8B5TRVRyVjrfoj1qSBsJcxfRT0yKnSskPfn8xcoHvPTy
         7lig==
X-Forwarded-Encrypted: i=1; AJvYcCVBJPksL1b19H4v597Z3qVy1e4AGWrzctdWJz+IRoQDH/y3aEO0cCkLihaJixWasSqDKPGx9c7LrXIFOeZiWOgxXrdGMKUJA+65VtZicA==
X-Gm-Message-State: AOJu0YyDrpIBEM4TXWjQLifXRaOvJi4nMDZSSkpcOC8swk1SknLH4IMH
	e2jHTM3oqamZVvKlK/VoTQTvLFh4CC4uvJU/CAiKnNO3xZI8Z0Md134C/P6U1Q==
X-Google-Smtp-Source: AGHT+IFbWEBS7zyWLhQM+vaS154zwpiwlRSUXx6fb3PU0OaHGhrlF2s4QfJATaNSxtzfHabbp/2uzA==
X-Received: by 2002:a05:6e02:13e4:b0:364:1b8f:8437 with SMTP id w4-20020a056e0213e400b003641b8f8437mr30680ilj.12.1707776145739;
        Mon, 12 Feb 2024 14:15:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8ALbNXelFqqBGCaho861sYQgXUcXf0rjGjPKnZWFceKsuueaMlNdDZZuJ5n3oJ72fVAK2LgYnstRInl9LO8JcpnpUVHfIjXWFzFz6v8CK1bATfMoV04nj8KbbqG0avwQVq5yTJDt7k/Lzbl7XSosyzumPDx6qt3M8puz8zphCkfnvGzTtvU9umgXK3EoniNVIRAAHMnR+sdlqZFj6l8eS+hsMVSAke/oKFq3iNU48oI0Dx/i+p9mgm5VLWC7ZMcGiFc0wKFQ/nvkiVq9rQwPTgyT5dptfGqJlgF2pEOGxr10d/Sjn4QdlIIyb9KkNgZTrIKIkGpmQXZLzR+O4eHe2rZoB3d5oMXi2ikczeWPxPXDuE8H2SNmWu8IhRcpROBGG9Sw0IKLu8IxmYL4rjcnnpF17dBvKLyhUWyyMt6C1yMWlINcVVpell4fva0Jlow1qCr8G9fkWBed3FiMS/wzqxf5EJeR8xQN+IISht0MU2XWA1QUpPHibGG+YTFDQOaqVzVZj38+NYZeFLJ+ueolP/VRTmhBpjxciMS44sjGJnkgiWgPU2cT6ha1FRWmh9NSbJXdpQgk8PGHDTeFBJLGACQFkgWJ+bcUn+yOdkc4n3Chs4tbIw/qJg9Veuwg9I7Xf6tVGOPp2+oRF4D5wZsciaZt7axcDu5BLDgJ7oQooWMc0eWYjGvZniJSkFaedjQDoHzKkGLKTjw5JRvWVYYTv23lxe6aLcQ/x9WezR4CTZkPOrPmSPw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x66-20020a636345000000b005dc191a1599sm961714pgb.1.2024.02.12.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:15:45 -0800 (PST)
Date: Mon, 12 Feb 2024 14:15:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 09/35] slab: objext: introduce objext_flags as
 extension to page_memcg_data_flags
Message-ID: <202402121415.4E74908@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-10-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-10-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:55PM -0800, Suren Baghdasaryan wrote:
> Introduce objext_flags to store additional objext flags unrelated to memcg.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
