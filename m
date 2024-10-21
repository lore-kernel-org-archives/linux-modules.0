Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D991D2781;
	Mon, 21 Oct 2024 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540536; cv=none; b=cUNFTD3N5TyyBQrRp6tA4ve80O1qMtiYg1si3C+doEEYN6YASjJFF5AlHQ3yuPPIrOSrfOmPsffd9n3uUImbig5iLI+ZD/hLMxJFYgFZRFhx1toWIfuU8BQj2cp69JcEfgDcJuQb8Z3jsZgTDSCekOtkzpEUVFnTJojqIIXm+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540536; c=relaxed/simple;
	bh=n37lJVam7IGyBaz/FCCZeXckTNXatensFR0ZP+GzKc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvitN2Ey+csboP9eCo8VI5RoHD7eSVzsZtZ/t+2NJGLR707kn2459JLxS/b61bxtOkgATV8TblhrSGkF4bqaorfc9o+aJ/aQ7Hy/3RFNGv/7/Ztt9QVARRqUaMG9seDdG8pXfPayuv6fC4S6tGae59fQvRvcvRuC3plseGdRXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPYvsXcJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPYvsXcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE26C4CEC3;
	Mon, 21 Oct 2024 19:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729540535;
	bh=n37lJVam7IGyBaz/FCCZeXckTNXatensFR0ZP+GzKc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPYvsXcJAaCauSbZitPtWtor8eskABXBYbPqy8AdcExDbrOSQ3SMjhPCjfrozV0iE
	 d2yMP8sHfI7XDEfgz1Yn+18r4xe9o+dGcjpv5cVT9Q+TH9J0/6gVQKL/7TMX0n/dyW
	 2Wr6Qfp+jwc43eM2rMifQTmAqXtiXRkfqJUq0NsMXqRfQXUlvOIyUJEfLALcdZrFmG
	 7vqrlyeVuiImWXVPxgHR8bnK0xJqnWC02D+WSLRc1CKwcQ5lYGXXr8URNXlZdqy3T7
	 nEwvHMho15HGHVZTSNbhDPZg69MCMFV+iy7M5hyQ3o+LAmgFKlffI7Q7tZix5pZRdP
	 i0FHTi9F0+AXA==
Date: Mon, 21 Oct 2024 12:55:34 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: check symbol name offsets
Message-ID: <ZxaxtnuAMuuTgN2I@bombadil.infradead.org>
References: <2hhrajjoxixnkhtlhhqzjxki4iuhr362345wgrmg6uzbfhlupo@hgbjsb5wizir>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2hhrajjoxixnkhtlhhqzjxki4iuhr362345wgrmg6uzbfhlupo@hgbjsb5wizir>

On Sat, Oct 19, 2024 at 04:15:32PM +0200, Tobias Stoeckmann wrote:
> It must be verified that the symbol name offsets point into the
> string table, not outside of it.
> 
> Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
> ---
> Proof of Concept:
> 
> 1. Create "poc.sh"
> 
> ```
> cat > poc.sh << EOF
> #!/bin/sh
> # Sets an illegal symbol name offset in supplied uncompressed module
> # usage: ./poc file.ko
> 
> MODULE="$1"
> BASE=$(readelf -S $MODULE | grep '\.symtab' | awk '{ print $5 }')
> if [ $(getconf LONG_BIT) = '64' ]
> then
> 	OFF=24
> else
> 	OFF=16
> fi
> ADDR=$(python -c "print(int(0x$BASE) + $OFF)")
> echo -n 'AAAA' | dd bs=1 count=4 of=$MODULE seek=$ADDR conv=notrunc
> echo $ADDR
> EOF
> ```
> 
> 2. Choose a module which works for your system (adjust if compressed)
> 
> ```
> cp $(find /lib/modules/$(uname -r) |grep ko$ | head -n 1) poc.ko
> ```
> 
> 3. Modify module
> 
> ```
> sh poc.sh poc.ko
> ```
> 
> 4. Try to insert
> 
> ```
> insmod poc.ko
> ```
> 
> In dmesg, you can see lines like:
> 
> ```
> BUG: unable to handle page fault for address: ffff9802022d6f81
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 100000067 P4D 100000067 PUD 0
> ---

Thanks! Any chance I can convince you to write you PoC as a new test
under lib/tests/module/, see my new patch which adds a new module
dedicated test [0] which you can build upon to add a new test there.

And then you can make a series with 3 patches for this and your prior one,
and you can just refer to the PoC in the fix.

[0] https://lkml.kernel.org/r/20241021193310.2014131-1-mcgrof@kernel.org

  Luis
