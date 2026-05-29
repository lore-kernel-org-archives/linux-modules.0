Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F234D3B5
	for <linux-modules@vger.kernel.org>; Fri, 29 May 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016722; cv=none; b=HwtzE7o609m8jR4tsPt/9O5bF+PVgux4WUcqPTBnNmERnLzUXPz37NOBHOaJLJYbSg2Pb3gOk+aZXWgok723B1LbIynqxb1Wnsg+/3ZRHt0CkKVKPU2FNwR/lJrYEMV5TG6xB9zsRI9nYv2bDkliAGwha+K240TQ8bv2S2gySDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016722; c=relaxed/simple;
	bh=1bEqHSCCKRDDQQinQnzVucKwHK7P1jobeJy5PtN3mEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0wxNWwgx+i2+ptsjlWtjJxVXZ2JLYkv+WbmvB8pUrUM9HZ7uluFDn3YTyDqJpRQOHHENbY6NoKQvV+SKNC7Aolmv1ucnXWueu5W4bHiUj/F6fhG1xkCxQWimIBDJJkKDVE1HgzKlTQRMR2OQ5xZGhY2LhQvDofu/Q40TRzc9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tZJK7yrN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZJK7yrN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba180a022dso695ad.1
        for <linux-modules@vger.kernel.org>; Thu, 28 May 2026 18:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780016720; x=1780621520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QSaewdY+ty5a2m2tiFLNtjVpl4qPVblZ3Qd1C7Nzpw=;
        b=tZJK7yrND4pk7cs3Ic3OUtbN418ArFwaX+zqoQU5wl6KO/KXNAiSsNyG5EOu3gmbmg
         HcR+asW1VJxcng79GRnCnnztNYojQcABaM5Fg099rrYHpk4pBri+MyL24GuOvaHQGhIi
         kvwY50qFjRBqXj7ivbpF7nXNNNsHQHj4cK2GBHIpCb/vzhcPViV+14wXDNAW8l0x6KK6
         PqPgDK+ttDR581p6RKUMi7marzCiI/2Q3ijvWNvHDXvVLWpiJqtGK8XeDfPGtwExDTxD
         jwCJ/XoLlHGrQRUkPJ8RCNKx1cqQ1kD+rHdUGb2M2pCiJuxKCY1WpbFcV/72Xv5XWyts
         Jl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780016720; x=1780621520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QSaewdY+ty5a2m2tiFLNtjVpl4qPVblZ3Qd1C7Nzpw=;
        b=UPOPER2aQRZeOx/bePeCHpfzSjboR10gm8r7NO8nnxUHTrl4QjXY9HRONQeiV1mOK6
         HUboaQwngWGaCLbJKTRpmppBHkUHd3+2gwIxidVyqm3NdDGg3qm+SlDb4Iu8QUGLfO4d
         vdnXQlMmr0Db0qxagckDlYY+nN+19dvSX7CdcqzNvnqhK4+7RhkxZXjOJF1oJzFMmYfY
         Ic4H3hCHbuJRf3KA7VZebn2WbAtfREuWNkh9Ak0Hh7NsgVlj15N61jil3QBQiFB/mZM+
         EC89viM9oyS7G3orGcZGn5B9wR8RVqBV/gA8AQdgwnTIZc9Q4a4PKeZq7KlYGjTkE1F/
         +lCA==
X-Forwarded-Encrypted: i=1; AFNElJ8OC12dzm77OQzmVFk3hFSl3j7VgW9TKKRU5dt6Nb69YDTi6G0AjaWmnsqfCgJgKv8/KgmwPv7P4DWuN8HK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/24LalqB1i3KaoLmXLOQjjEnS6e2QxIV55SCqT/lsNN2mlQrP
	bfaQbW9qfK3LfqGS0pA94StSV8RZENCCHNV4A4kVX1coCOEZTYpwZuMCqVD4/Ox7Pw==
X-Gm-Gg: Acq92OH6gB7tF6bkiNpy4+F1ImkGuGq/tRPW2jOVZYoZ6J5am2K/l6GlNDzAvczbl3Q
	22mp/J33HguKSYnP0k9AllyqOeigYZdlToXGww0GgyrgVTht3ZwHIkJp97ybEe4J+BN76zoJuvw
	Qpr8bTzTUVk+/iYy67PnUCZLJMii2bR/MVyZ1Oz/L/z6JUAIg+uLYEuKgzWWBZV6J/dlgOTo22A
	WzG7r6464Ji+psPhXjefNoEH0fLQOXDw2nTnuFu1IXgsbsuvCdekNUlkyhuVMpO4XgWJiMc1pAF
	+DWUxQi4cftJ7yBAwnhE4yYe/AefrgS6/05GVunRzhOUMCRQ0Va555eNMecBzofQfSdu4qlvzUI
	qXjtCYrUWNuQxcbVqN9hR0k16Qi4TPuiFMTVoYYm1Nft6rzF2O36o7NgdBc/QhPQDocclclAYvw
	BmJUQPCFlqLeWeTnHZLMFEWDq3AMmiH0aqz2j+L4jI+fGArQcwnD4jhFz+DTWtuKDk6OM51+bf5
	3gM5Q==
X-Received: by 2002:a17:903:ad0:b0:2b4:60e6:44bc with SMTP id d9443c01a7336-2bf22eb5525mr266985ad.13.1780016719847;
        Thu, 28 May 2026 18:05:19 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e5d83sm318045ad.8.2026.05.28.18.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:05:19 -0700 (PDT)
Date: Fri, 29 May 2026 01:05:14 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Kenny Glowner <sisyphuscode0311@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: module_param: add missing newline to pr_warn
Message-ID: <20260529010514.GA2807207@google.com>
References: <20260521161405.64042-1-SisyphusCode0311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521161405.64042-1-SisyphusCode0311@gmail.com>

On Thu, May 21, 2026 at 11:14:05AM -0500, Kenny Glowner wrote:
> Add a trailing newline ('\n') to the pr_warn! call in set_param to
> ensure the kernel ring buffer flushes the message correctly and
> prevents log line smearing.
> 

Applied to modules-next, thanks!

[1/1] rust: module_param: add missing newline to pr_warn_once
      commit: ae12a56ba16adcb8a06d5b3b91d4f82a092e8de3

Best regards,

	Sami
