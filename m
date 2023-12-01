Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CK7Uz4En"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399CF10EA;
	Fri,  1 Dec 2023 07:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701445872; x=1732981872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XsNUWDRj6WzJ145IqU1qVNm6f3JFiLIEhj82z7TmYic=;
  b=CK7Uz4EnV8cPxNSmiFM1rBRyYj1VbMLJO8BXFdGebeZ8r3o4qRGqvoyo
   9YlY9PHkTCiBMbxlKtYRfVp4V17mThgpwb7oo7fvuvJ+yTBnFYBgw/PVb
   D2ikdO+Cz3WTaxBTv8rzjdkif2qtfwSC0V51RSjLSol9FEjs0wRCBXkcK
   yl2pkJQC8YmvFSJfqSL44l9I+r9wVb/IiZaNfxqdrMFzS0Rn0Pa3bM2dh
   I/XJyTkL+N98xkYyB8QkPo5gpZv9YaUXxMhrEaBNcI8nw/cHhsEx0bAwG
   mvDoKfQxusbBPSc/Nq7WqGNYi2/9PUpBTWmldYgd63WJ25fvtBGT0c9GE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="460008704"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="460008704"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="763187689"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="763187689"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:51:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1r95nH-000000011p6-1tuk;
	Fri, 01 Dec 2023 17:51:07 +0200
Date: Fri, 1 Dec 2023 17:51:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/5] params: harden string ops and allocatio ops
Message-ID: <ZWoA6w3A7f0CDYnu@smile.fi.intel.com>
References: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 20, 2023 at 05:11:41PM +0200, Andy Shevchenko wrote:
> A couple of patches are for get the string ops, used in the module,
> slightly harden. On top a few cleanups.
> 
> Since the main part is rather hardening, I think the Kees' tree is
> the best fit for the series. It also possible to route via Greg's
> sysfs (driver core?), but I'm open for another option(s).

Kees, Greg, can you apply this series?
Or should I do something about it?

-- 
With Best Regards,
Andy Shevchenko


