Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA02BEC39
	for <linux-modules@vger.kernel.org>; Wed, 13 Aug 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077622; cv=none; b=LtXK17JzLOjDGqUPG/yTOEhFYOv9rJx31ThyCVZPFK/QsHg8bo5VEtDzJzAiKb2XgByUfeb0AdCacbSY4zX/Y/HA8Cf3YunidrAcVvfTJkj8kKl/WWb8GBsh8NsDapSRrZsAL92CZzP/Vn/W5hd2WAS8/TtAi7qc0uYJPSjB4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077622; c=relaxed/simple;
	bh=eBledXq1IgU3Oseqe5FTx74iAqZSm6cqot/95aBsh7k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FMqPK3j+6wLQeR1DO6Umv33ocjDQMb7hFguyhgiHxBkJZBSjROPXuWmXikynQCNAShpjb27vG3sFZttJKLIk+LXI/XMBskgKuOTvDQdtc7V6JOjndUKjxz0fJyaYIBxxOLqZ1pUDjaioFnvENUyD/Zs7NYNGsXlQHZzWQ7gY6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h9ouHArw; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h9ouHArw"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755077615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBledXq1IgU3Oseqe5FTx74iAqZSm6cqot/95aBsh7k=;
	b=h9ouHArwwwnH6/Js/k70gvN7pO3qvsXGRbzh/OSSkpEVbNEl/av0wucP9k00wWJofIZF72
	NkxKWe2AVd1POVKkxzpunho7CbMfoSgersp21Cm2HuD3h+c3kAKxl9MzvR/1vqKusGDiHq
	ErYquQEJZfJWKSzDELjxZNHULY9ziNg=
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] params: Replace deprecated strcpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <5d334a1f-0dbd-4e25-bbc5-b01aca369385@suse.com>
Date: Wed, 13 Aug 2025 11:33:18 +0200
Cc: =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shyam Saini <shyamsaini@linux.microsoft.com>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Dmitry Antipov <dmantipov@yandex.ru>,
 linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F640B308-C8C4-439B-8217-98FFC10BB76B@linux.dev>
References: <20250810214456.2236-1-thorsten.blum@linux.dev>
 <5d334a1f-0dbd-4e25-bbc5-b01aca369385@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>
X-Migadu-Flow: FLOW_OUT

Hi Petr,

On 13. Aug 2025, at 10:59, Petr Pavlu wrote:
> Since the code already calculated the length of val and that it fits
> into kps->string, is there any advantage (or disadvantage) to using
> strscpy() over memcpy()?

strscpy() guarantees that the destination buffer 'kps->string' is always
NUL-terminated, even if the source 'val' is not. memcpy() just copies
the bytes as they are.

If it were guaranteed that 'val' is always NUL-terminated, memcpy()
would be fine too, but since param_set_copystring() is exported, we
probably can't make that assumption.

> I think this can go through the modules tree. I've CC'd the mailing
> list.

Thanks,
Thorsten

