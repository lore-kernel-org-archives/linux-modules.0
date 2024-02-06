Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B0DDC5
	for <linux-modules@vger.kernel.org>; Tue,  6 Feb 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242301; cv=none; b=p9NZ1kAnPatpAteS8jldLw62QgJOJc5L064uY2s9uoNi0zaiu1W1pyFzbVSISxZcNzZpYPyxdqDSKeoXUrZknB/5VNJ1cf25/zQ+gSy04utBG3TDtrdF+aNRt4T+ZtkdUPhA0mCFEflygU5J8z0MUEeIngBE2iN7IswyrLceZ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242301; c=relaxed/simple;
	bh=Djl1/U6IUulgTbHw63OTLo2k0Ug3gGa8kUmd0yfMba8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEziZKSrJwI+aqltvEY+4hMOTuNl/3kBWkvB+LBsbP3U0BzhhvKaQSj/ooCj+3ooOIRMFDb3Vhjqbz5qL0CNij61uwhG4IMMWhHi8PvUzCRfWnid3WTQrjpQ5VdouUwH4sRlPUsg3OjkLeSNLK7FG5tz3ViJ/SsIfv0DHc1lI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z7779fh5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z7779fh5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6RVgzy3XE40P2AZQ+//++Ax5MB6hk+ZedVhtqIV7mTw=; b=z7779fh5gJRqnMJFv72qY148Y5
	JnoFE5hshwBD2htc6ziFIskp2grSZpibKU2kSdD+Y2HDpVP8g9QW87G/cEvfHmQKNCK5I2ZjFJvGP
	0p7LZpjdur3HvWxwhbQDWT4ajopK5CGK1GuML2U/Unj6+pA2vuKOU9FFN9eFdPd5qhPnw+ZyTpzWI
	Tj8dI2A6IWlTKT4EBTE5Ch+SVxha49YNrTJSKidOS10e5AK/JkcycGB6sbrBL1ZGhwMXFt++62Qgn
	/SydRFwJ1iTOuHoA8I7EXXf8aasIGpv45UlqJ4PLEvjElG6nTnV1paRPSNZ+Z25vjQR9IRhD6KPA8
	O3jf0lnQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXPi8-00000008Tdw-0Aca;
	Tue, 06 Feb 2024 17:58:20 +0000
Date: Tue, 6 Feb 2024 09:58:19 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/4] ci: drop travis config
Message-ID: <ZcJzOy26gvs4vs_r@bombadil.infradead.org>
References: <20240202190823.418148-1-lucas.de.marchi@gmail.com>
 <20240202190823.418148-3-lucas.de.marchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202190823.418148-3-lucas.de.marchi@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 02, 2024 at 01:08:21PM -0600, Lucas De Marchi wrote:
> We are not using travis anymore for CI. Drop its configuration.
> 
> Signed-off-by: Lucas De Marchi <lucas.de.marchi@gmail.com>

What is being used to CI testing for userspace?
 
  Luis
