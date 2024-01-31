Received: from attila.bofh.it (attila.bofh.it [85.94.204.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCC8286C
	for <linux-modules@vger.kernel.org>; Wed, 31 Jan 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.94.204.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710223; cv=none; b=mzujVe64oMoDQX+xYdLuLblMAFnFvEharHYhwEJEnymXZ5hRL46/thAJ0mRKSvMk4+xCSlmEYRV0eCrBaUekIDMxifyGHHsZTNjkUDAAIpzFnQO4F/m+GfUi35Pv3vuT1qrtG9pvvqEHHUKNIgR36hz1iRRU5CTIBi4Kkc3Kozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710223; c=relaxed/simple;
	bh=MP4+kQwmwvV2yLepNQTBcELEedr4e4V8J48y/01XwJE=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhpTgguBzmhlrXRTeKm8Y4IKHuzKpOZmOiZBDXozkzNxNgBlpKaY7r1Z0tK0h7/30SQPRqHBmehBQk0W/Moijhqk4G0ftHopCcB+66BD6E/cHIv2MqMEHLyj+YssaqnQbNGz3C6qdx27s4Lmrcpt+CSwdASuxW1yEj5n+jA5wY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.it; spf=fail smtp.mailfrom=linux.it; dkim=pass (1024-bit key) header.d=linux.it header.i=@linux.it header.b=DmfJbM8d; arc=none smtp.client-ip=85.94.204.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.it
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.it header.i=@linux.it header.b="DmfJbM8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.it;
 i=@linux.it; q=dns/txt; s=attila; t=1706709839; h=date : from : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to : from; bh=MP4+kQwmwvV2yLepNQTBcELEedr4e4V8J48y/01XwJE=;
 b=DmfJbM8dtybQQAOEfigFNKGiEutcyR9lDh09SaXe6KfSgUKyXVq9IcRimOYFp2RTP57Mt
 d7ljUmjOHhm85CxIhCqbV09BkRwnfFKXwJ/C2IhRwWaDPeVzyT/4GMBZCZGxQ5RK3wzsqlK
 s7qTFx1W9MojbWd+zd0/EOh5vCaUNNM=
Received: by attila.bofh.it (Postfix, from userid 10)
	id AF2C417C1482; Wed, 31 Jan 2024 15:03:59 +0100 (CET)
Received: by bongo.bofh.it (Postfix, from userid 1000)
	id B6EB253096C; Wed, 31 Jan 2024 14:52:49 +0100 (CET)
Date: Wed, 31 Jan 2024 14:52:49 +0100
From: Marco d'Itri <md@linux.it>
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
Message-ID: <ZbpQseTjiicQstX3@bongo.bofh.it>
References: <20240126-master-v1-0-6257d039a30a@gmail.com>
 <20240126-master-v1-2-6257d039a30a@gmail.com>
 <tdvymg3uuvkns4uqvivvvkj7sf6pqr45rpbyqmngaf3jmvqije@fsuvyu3kai54>
 <CACvgo52Eb1MV328RPUPLDq8cPO+7NvHn70q3SQdiTr_apnE5dQ@mail.gmail.com>
 <wqvtxyw6h6mcdnqv3cv4kzorlck3qzcb4p3duq6m3w7lm6isxl@kupxidkj3x3w>
 <CACvgo53aataYSQD6jmz-+sr7s4ZoEv0WAqVM_LDxwzcecN8BwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo53aataYSQD6jmz-+sr7s4ZoEv0WAqVM_LDxwzcecN8BwA@mail.gmail.com>

On Jan 31, Emil Velikov <emil.l.velikov@gmail.com> wrote:

> Debian - installs kmod in /usr/bin and symlinks are split across
> /usr/bin and /usr/sbin. Cannot find any references if they're aiming
> to merge /usr/bin and /usr/sbin.
There are no such plans at this point.
I definitely will not be pushing for that, but somebody else might.

-- 
ciao,
Marco
