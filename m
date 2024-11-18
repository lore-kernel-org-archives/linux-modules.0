Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F919923C;
	Mon, 18 Nov 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938649; cv=none; b=C+5VL0RgcHTZW/xzYzbd3h02K+P3gN7jqVhxR6ELb+YCjbuU57Y3+FFS1mHDWugHjKOBEUUgswWrj9+H7YO6Pu/vEFkk/FqIbCmbjJMiAqJOB3jQaiZkzz8TYLZfEjaPkC44SHRml4oC598GSF6HGZvCRmBYVkMMPCPgYpSd+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938649; c=relaxed/simple;
	bh=2fTyCTdjlOUp1jeLsMB22Hjo9p8qmllhGShucuPmrcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcnjtUzs6KBtQchaBP6+NM5uBvawZus5IUI/Dz3ilGusZxZJtU24ibjj+SGTciOCs5uW6iq5XnQllEk89XHqc4RRDsAkgHor2KeU33j5kZ+9ua298KfF6iBfTu03YJakpwM0+Td4HL+Tuj0K1UMEHRYbGPJI81Wh/Dv/jXGfNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XlUzgVwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XlUzgVwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E11C4CECC;
	Mon, 18 Nov 2024 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731938648;
	bh=2fTyCTdjlOUp1jeLsMB22Hjo9p8qmllhGShucuPmrcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlUzgVwZeLLUku5L/HPS0MdcUF1JNDorGzzxikoo78QS+GV3AR5+BZCKzXsrcvirN
	 +97iflMwbM26K2GK7HS0EVAeI9xJFY9XojcYctTbsg23L1B55r/RNj6aAGyznV/0hM
	 N3DXDHjZNvB5hbACL4CxAEUIZzSLns7D2D3Bozys=
Date: Mon, 18 Nov 2024 15:03:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Daniel Gomez <d+samsung@kruces.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Werner Sembach <wse@tuxedocomputers.com>, mcgrof@kernel.org,
	petr.pavlu@suse.com, samitolvanen@google.com,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@leemhuis.info, vv@tuxedocomputers.com, cs@tuxedo.de,
	linux-spdx@vger.kernel.org
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
Message-ID: <2024111821-gathering-storage-04c3@gregkh>
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
 <20241115185253.1299264-3-wse@tuxedocomputers.com>
 <D5NGCPSP7EO8.28YI337NY203X@kruces.com>
 <CGME20241116172026eucas1p2ae18643501640a7c6a3a796c30b60fed@eucas1p2.samsung.com>
 <wnfqe7q2aby76zokkh77jhlwc2dbr243kycmejc4wj5wflywgi@6sox742ip22g>
 <D5P6NQ9ZWP13.K9G49CLMO6LV@samsung.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D5P6NQ9ZWP13.K9G49CLMO6LV@samsung.com>

On Mon, Nov 18, 2024 at 10:05:27AM +0100, Daniel Gomez wrote:
> Thomas, Greg, are we using any specific SPDX version for kernel license
> identifiers? Why the new identifiers where amended as valid and not
> replacing [2] the old ones? Was it to avoid replacing all files with the
> old id?

Yes it was.  Let's worry about getting all files in the kernel properly
tagged before even considering moving to newer versions of the SPDX
specification.  When we started this, we used the most up to date tags,
but then they changed, and we didn't want to change all of the kernel
while half-way in the middle of the conversion.

Just leave it as-is please.

thanks,

greg k-h
