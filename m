Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B41CDFA3
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704400; cv=none; b=Au9F6Bno91OeKSD6z8mMU06mWMVtcKOHNxhn6bqaKSMdki+Lt6yeoa2n0gqrZC6Ttg/Vn3612im9hEK+80t2SNhQkNkwNzJAxAUPbP6MAn6WPyUGR1lgfFyLX74c6miDp765fCPmpzXENeEFRoU8aJih/kmaoZRbRKjZ4IP6aEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704400; c=relaxed/simple;
	bh=AWFBW7FfgrM+D0zC+8M4nTbfzWykLXKE0+MpT5ILXww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bf7qmx8TVFUbrWeoYbTUXHHEXuDmAMedPhMYJxTd5kXE48K69LPxTAjBz90kCqCzXFnjtGSS0xCnQTVsdcAIHeRRvoLtNkDMjWcri9fieMTrx3vZEafQVyHZsiz8pbfFheB0L+T0moA3k23dDRcS0RqBfDDTVpF2IYoVuhKISRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=EnZu6QES; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="EnZu6QES"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e6005781c0so72326b6e.3
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729704398; x=1730309198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWFBW7FfgrM+D0zC+8M4nTbfzWykLXKE0+MpT5ILXww=;
        b=EnZu6QESoIdhW8vlu4RqzQbCSGfT6mqSvKiUVX/7AbTn/7Qn7jmPyu2tR65YwQiZ0n
         vpxclIUM5l6EpwBi8OM6lAaJ59EzLVTJmhwUhdNTUtXovMg/6k9uK1ODp68YEdnMLH94
         e1J1Nw98Svz6TUev/GE0LX/rUcLlErJ0kZ5FU6xvsARVRb8z0zDhEDD8+HFw73lXdaQ7
         BzlMdN6VCfaOrxWGUWdu58cHikN3Rd9EpfzZ6jIo1cPV3mN6e26bEymqFleDDdAQTCRX
         ggUOaNqw3z7XO0eC8hzToHqUTdqAsCXhkSlKZ94E7guFlVlrMASXmklyjUcl7SYUDDie
         0h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704398; x=1730309198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWFBW7FfgrM+D0zC+8M4nTbfzWykLXKE0+MpT5ILXww=;
        b=hbfkPwaA2FlhD0ryY8TmQn0LWehkC3Qx0F22VPqw/6sq3xs9wkAa3qn6K0enow1Pem
         VhMqT3HicT7f80yZBeGjrMJu7vnhU+UAS1Qh60WQ+f8Gr+dEu1FtteZKe1lTSXmCJdwR
         zIaVZYymOEOHTpeuEYBXJuHgflk08qljsA8JUEp3uy2+69L6iCqgGmieaWYdNG20Q6Sr
         AGkrHvg1AHdA39OU0TVzCuJ4JjVNy38r/VsUnxw44p4FlOw8171dJcIIl/ImkVHUrS7S
         /Z/1LyTWgTPADTFIrqMzesIPU1pal0LCMewrMlLfyVKu/tgNhkZCjoGs81WSOcKmrzHY
         i2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXcJe2jv0z+phLiuOAXVB9LI2m9MTz+fIr0cw6I6r61ZUDB6h7lKvUcWD6WhVjNW0eJTCVg+DkDVSiAPru@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2eUC0qGEvbMJtHGEAuRLDU+bPQwdc+MrbgD6kOYoPPa9QqRD
	T+iQ28YPyDvBsIxZ3thq6KXx6yO4xjhqwfdAie/MnW2ftKiS2FefLSsJXR0phYz2ukaVjiNqm9u
	EuLtb0XEZB2O/Dd6XSKNPl0fZJ+8iBHoDJzZ+qA==
X-Google-Smtp-Source: AGHT+IGckBdU29o3tk+wYPFoKwsMk5i6ERT8sORHYNIiU6+p/6iCZVXQYympbyvyWVcQV7nCYD9zoCsM5F2gZ83otEQ=
X-Received: by 2002:a05:6808:3991:b0:3e6:23fb:b391 with SMTP id
 5614622812f47-3e6244eb667mr3799063b6e.2.1729704398543; Wed, 23 Oct 2024
 10:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-3-surenb@google.com>
In-Reply-To: <20241023170759.999909-3-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 13:26:01 -0400
Message-ID: <CA+CK2bAZ4K+1ZZyFwwZ43Q9SMPzSr=9r=OvqjNK16Ai3E92jtg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] alloc_tag: introduce shutdown_mem_profiling helper function
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Implement a helper function to disable memory allocation profiling and
> use it when creation of /proc/allocinfo fails.
> Ensure /proc/allocinfo does not get created when memory allocation
> profiling is disabled.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
