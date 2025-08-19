Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B0253F3C
	for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613085; cv=fail; b=Y/yDnCViEnN9WBkTeT9KpA2mVs8vwWlp6UU9M+s5Au7U5tGk6M2JNg5V04ktTVu7lY6l8qGG5ge/gMSturWQBU7CquKMN03fdxdGNsedQCn9WjuDh+lnAauCWEUw6YnASC0hhdEmRFRuPG8YSuCsduCnA6VJ7GDNUJIIFOU35FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613085; c=relaxed/simple;
	bh=28JOznVohWVC1jRMGLvT6WCMOtirQeZBYHPceM/7Yd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fgu1k+Bop3Ux6ot+Q2lt4ZZSJdUlHUo1P6kq2ziIIG/8qpr/XBUENFO5jIwImfEpYe9ICP9lECKiBO3t2rrVANd/E6eusypo8suYuYqTPYQ/7WIAK5QWqSIlvPxn/i5O21XXyVHCIB3Cd81oEcEvJhhPRwgSC6eThf3p/GswK50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zg913YHk; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zg913YHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755613083; x=1787149083;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=28JOznVohWVC1jRMGLvT6WCMOtirQeZBYHPceM/7Yd8=;
  b=Zg913YHk27AY92MlKfcLT+5Zt3Z/AmlGrPblF3LC2Kd7vWjqmf1gwhSa
   x/0QbiH7SQThXll5+u/tFNttbJavbtLi0kYbE/jicGBCg68gmeaTD+OiY
   c5EO12MdX9TVfICO3xbJf7JfNtbgT44KUdh8GNgCnFvybbS1Bdw89t8kI
   Z0schRErgWtfsNSXgeC1jtBGCkpgOl44p2wjGFztE1zYB/npYKt78EfUx
   PUHOKGO9WUqnFjWlvuj8/U9znsiTx3zFlNhV4SHBYZWaMpgYuFfWew61h
   5RM2ZDuStoo0lVzB3xu+GNug/9iJFtfJjlHnQMAU9XhDmC0ObFGUcnKNs
   A==;
X-CSE-ConnectionGUID: FaMUWut1QnivygBHAx7lyQ==
X-CSE-MsgGUID: Ragz28o+TdCdFPLMgiC5mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57784142"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57784142"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 07:18:01 -0700
X-CSE-ConnectionGUID: 3OU7OPR9S32OM2gsA9472g==
X-CSE-MsgGUID: +Hhh+O2WSTSWu1oVgaAvdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="198874565"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 07:18:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 07:18:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 07:18:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.51)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 07:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cdn3lc3490eo0tk3bXhOft7xfs4h1zTUHCKGmLl4fNbOV5lLQhdHkD6pqjdNgMdylehU6pFwMiZNdxHnHY53qMPKdiUNAv8codab51C8khYIK01rCqYPZhSvWaQyQ/jLCsVs0YycT1JxT2BT/BOxg7oyrdzonormxQuXOlD5MZSd9Ue5ur0vRB5JNAdRwoPK2ayF+F6oR4tsU98FYeFyH1oB33rm0wLYll+8K7r5ajPREA8YScj57RUtvYbcUrpO3z0h+gg4czBOp3sMCMRjiPNcB3DAQGZ1YcfBpd448ZkcP7hFzOQLuoLdt1gV0OPxThZ83a6cWfWIB2XODBlejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g2yEgHnNOir1zb73waDL6ACXx4YKicqdlmt1Statdo=;
 b=v4IDszsD0l9LIA8lR8kLjYO2uAClgmcx9dhGd70PAkHLV3dTekzeu8SnEgEYKCqDX2CVCWZNh0fcEoh7rBswZ0D+j5L0tRbICsdsN3NqFwl7RfIJOkjQRSJFujspa9oJcH8ciBvbcrCaqTqkzphRF2shCWukAEWVTQrfLpDRPvRKO6vxI+sNVv838iGMGJ6McHcEdXye/t9uxpKxEPUW6Ge8w4J20RH7NQ392pyGwRZckVyS/Gi6yOIM2fqQncxsJi8R2+bZ0pSykMNeOnnARR3hIol1CsFAVwx6XD2CT+zLrUok5KHHpXnmMEyHYhkOONu+FaFfcsWQbxKYpo/zxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 14:17:53 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 14:17:53 +0000
Date: Tue, 19 Aug 2025 09:17:50 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
CC: Phil Sutter <phil@nwl.cc>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	<linux-modules@vger.kernel.org>, Yi Chen <yiche@redhat.com>
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
Message-ID: <i4ayzta5zgltyubg6bfr4mwqhl6goyh73lyc7j7m3vngvpooi3@boorlngxpi52>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
 <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
 <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
 <02be4b86-330e-4f93-ba79-8218d05659ba@suse.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02be4b86-330e-4f93-ba79-8218d05659ba@suse.com>
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ0PR11MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: d087f1ea-bbb9-471d-1f11-08dddf2b2f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?BB00/y6Os5TOvuKsUYoRWK1Ib1Wji4bsSZk/gIwyytEzwWCiE9S3wZLomc?=
 =?iso-8859-1?Q?9y/amEhaeB2q3pid5y7PsT/gACc9XzrcwjLVYCpCIcRsh2Sz9LFbmdw4Z9?=
 =?iso-8859-1?Q?laMhRVbc/VOME1qpUo7lmxqQSSVgZijyTediCb+rRMFIiuYmih3Y4YRlGF?=
 =?iso-8859-1?Q?PWMaErlVVThaV/p9tbt16bSQ26r/ITguwITFbQOIyxkwpTg/IETbsFW+1p?=
 =?iso-8859-1?Q?RuXn21Jpzdn7gjyz5t3kT9slD3rjpK+pS7tW00PWy6Stky3HEkGn4ib5JV?=
 =?iso-8859-1?Q?we0VUA8nvA1N/UVUq/Ug5aJbf52kfSHewtnthrvY6b7/NFPF03UWIBbows?=
 =?iso-8859-1?Q?zG2yceisEr580pz4yhk+k8eVr91bC9ogvNFK8ES2BOVCG5ftOXRZnkb7E3?=
 =?iso-8859-1?Q?PKGtMCk865rOpObgJXlawRxBMgOBxDyrVk5bd3cXRMe1bzOy71fkPicosH?=
 =?iso-8859-1?Q?edcIAiS4FLN2Vh5qMGT15ocZ0kePQfs626oAC/TonyQ4J0WfiqiIoilqZ5?=
 =?iso-8859-1?Q?Uk9IDF+ReyxVcAAVUKrQRVoNRzjb+59KvwUX/7NSHmxNIrA7y0i9rlUmwx?=
 =?iso-8859-1?Q?OHEA7lx8KJUZg6SUJu6kod9RMo1zXjq2Cwu9g9NAusmdlFyL8cTJn1P3dx?=
 =?iso-8859-1?Q?A+p+Gn6DPzs0txQFUONKTVDHK0t9MmwTVdDLfsqkcuxWMcZOy2W2haRwdp?=
 =?iso-8859-1?Q?Yhww8HyilyFWMI7qbcbUEc1VOYQfMMuy5YJcVXEqdh7OQyIzFiA71jGq6A?=
 =?iso-8859-1?Q?jg5jJqRF5HXL9Y6ItCYnAPQ5IRM8k24t/PpTkalcHaXFHva+2P/wWhcLWD?=
 =?iso-8859-1?Q?I7J0S203b50Rwg+aL1mN0WJINYu0AkYNVZn+Q88AX714JsfgPjBhzjJ/A0?=
 =?iso-8859-1?Q?j4BZNd1MvAfoVfZe7Cw6reo+PY4R1aG3M7sA0ioJgegr8Yel+pvof4p4ZX?=
 =?iso-8859-1?Q?njJ685Zk4LmUW6u32NiNr2YN5G5dBxVmY1Q7GEU2H/yVWRWzU5dlWMSvDq?=
 =?iso-8859-1?Q?wnaFUrdoOJaCA04bfiQy9nO9QNZ6h1HnVIEIsmrCWYxjw6ZDd7MIeWTErX?=
 =?iso-8859-1?Q?sXS7MaYKgz37n5FHgRal2JokcXqcryEL/FTq6CDQkV9x5LM6fJSYEeRzXf?=
 =?iso-8859-1?Q?LLy6YkCNOKipne6o/eN22u+PqJOIlClfwBndj4wD4cTrzRKxch967wCXk+?=
 =?iso-8859-1?Q?xCIfxDxeGz7xhXIsLTc5BEp3vwy3vmh/BN62KvLvVJbY14x2fIjlsrQrqH?=
 =?iso-8859-1?Q?m9dC0MzI8DHL5dEMT0RATsmdnik+9to6NNX8xPb1Kp9u8YzLCl+8GUdoj3?=
 =?iso-8859-1?Q?axC0Kp54uAIIpc6pIjN8rD/V73NW79ealMcuTkPVafgJQ7Wmjsh9ibHZXV?=
 =?iso-8859-1?Q?lVrMYwNHTq/pywxJtDp7oQbbmYJp55o0cy87solB+K9TI5tqg2F1s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hjp5F39PyoXuI2XtlCe7P9xRNXt2ChV/1iteVxLFvKBnUyFw3aKRfHsYxg?=
 =?iso-8859-1?Q?YpuyzAzqnNpatHsAuAUrt9rrJ+Oli09Z20hkXWvcsFLmPsAlrjfwPOtvUM?=
 =?iso-8859-1?Q?uWyKMIw6muIZJa1n6KTTiRr4MVy6mLAuDNWxVvfGWOQLrUam+RpbfObESm?=
 =?iso-8859-1?Q?6JJ/PRte1S3qxh6Uor2D5YdeM84alYkqdSxSJgGnj0YMH4eG/Q1QgjFgNu?=
 =?iso-8859-1?Q?QESOp9hApgVyT+KTFqrd+sdZrBeT+8V+9tfIlXehfOTHiWXAKS8ckjBnA9?=
 =?iso-8859-1?Q?lWtMMAbBecjUc1y7HRLMczS0SUyZrHXGqR7qIRBb9e/F5dLzQnbrN73yEl?=
 =?iso-8859-1?Q?8ZjDamTKYabL3J/AqH5OJkXdshJwIqmPC9rU9kBCZ797KbUoi4IQVph/vs?=
 =?iso-8859-1?Q?k2AWKhCizaKJ1IzXclH9CxnEfk+fCof0/w5xp/9zolprWwcuHQoVawbj5z?=
 =?iso-8859-1?Q?FNafsLlzKYLWRWTV1Opn8AxxpKPtUYdU+19JBwUu1FyRncBaNcFbXCMh2U?=
 =?iso-8859-1?Q?8UEjsdY8EvafTns2K1zqZrHp2MM564sPgH5ccF2rDBUwgrpuQlFOeJ4LkC?=
 =?iso-8859-1?Q?K81Fv2jSiye86KleadP4lfHGUoG9Yg6rNqBokYCN1LT+Dl1rcDkWEsFbus?=
 =?iso-8859-1?Q?UPl2EYwViYhPNmMpMPeUYRHKZPa/HDgFWkCzX4WB3O4czyyu/I1ZQVb0n3?=
 =?iso-8859-1?Q?03JN0KivgT9kmdJa6CFNPzWTY5qHcSirPaa/KnbzW07xOkVtuQloyYAvMZ?=
 =?iso-8859-1?Q?c5QlpzO0xViW185w1JyPtZoEb89yah5G3EYnrxdbhGHr2jd7hwHPQd7BIV?=
 =?iso-8859-1?Q?44ub0tglt2AimI6KQk5X2cJnAKHEyT8/mJeXauI9Fy7P8/FOn+ZA/gRiH6?=
 =?iso-8859-1?Q?H9Cl9xu9/CEdDrDXoJoRt7E6A4v0fphHXXGkfbFVSmTKbP/HU5RoBBaQge?=
 =?iso-8859-1?Q?AWZxuQslVRHZotswcDyAVi2A5F02EEWeza7n3cbOlbTyUNUm5C3++lhf6p?=
 =?iso-8859-1?Q?9cZm+YvlYnkBGdDaPZAbckroHi/hD9AI6afyXXVMW3SYVGOicW6GsOAgSU?=
 =?iso-8859-1?Q?h2NcETz50jo3EJyo9aBo9CZhfIKfu0jPtIwpfj2J4N6FGDbey51FvvMgDc?=
 =?iso-8859-1?Q?HcApF3KUoguLwmaMr2D0LD7ntccG9YdaL8VnR7TfgHcMEeLcOuiiKl4ZUI?=
 =?iso-8859-1?Q?O31DFy6xJ1LmQ+UTNsrtbWRvXw5r93VKUOluS/958utCir44l+MIm0HUPg?=
 =?iso-8859-1?Q?yGGhyhJNhiFDwFaSxKREXPl9AtdqLTf5PbfTmYU6FO1cS6zETuE0lbmlkl?=
 =?iso-8859-1?Q?+fefGuciTJgKO+MI3vX4MabVuV84lA+C+iRixu5KfOmHXnf3M7S2VAV2MX?=
 =?iso-8859-1?Q?jdK//1Omvqi01s9l9t46BeCLPZ1bsNEx5inEUgjXthaGa7Eiz1rT8rs5hY?=
 =?iso-8859-1?Q?I2gp+Zs2b23cixzCEWlvnLjPefcgPOrDVZ1JWpmLAJ+7oBKzLxG4Aly3nU?=
 =?iso-8859-1?Q?GFb4/Al5XM4/qNk65Rb3pPYq3+BGjPkdcIiHFYBvESt1EAovZaJ0qf2hHO?=
 =?iso-8859-1?Q?zUKF/Y1/l8VTvry32OIUqCDluWjIc86Oy5Qu+CaN6YsYvtMh/tDjiJgFQh?=
 =?iso-8859-1?Q?32L2uSQJiQcjKAQcCJ1/EVFBnuw1wscup6tU1KvxwdLUa1i2kj6QTjtg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d087f1ea-bbb9-471d-1f11-08dddf2b2f83
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:17:53.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2sOlBmiV2lesBPB0rI59abPVbbyVdI/DbkQN53yvtmi8V2fRYnf9MJ2fH2IjKNrqZH2P733FsYtaiq2aemefNerKHbCHZdfFO//BNz3Ors=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com

On Tue, Aug 19, 2025 at 10:52:16AM +0200, Petr Pavlu wrote:
>On 8/18/25 11:34 AM, Phil Sutter wrote:
>> On Sun, Aug 17, 2025 at 05:54:27PM +0200, Christophe Leroy wrote:
>>> Le 17/08/2025 à 01:33, Phil Sutter a écrit :
>>>> [Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> Hi,
>>>>
>>>> I admittedly didn't fully analyze the cause, but on my system a call to:
>>>>
>>>> # insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko
>>>>
>>>> fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
>>>> tcp'). A call to:
>>>>
>>>> # modprobe nf_conntrack_ftp
>>>>
>>>> though returns 0 even though module loading fails. Is there a bug in
>>>> modprobe error status handling?
>>>>
>>>
>>> Read the man page : https://linux.die.net/man/8/modprobe
>>>
>>> In the man page I see:
>>>
>>>             Normally, modprobe will succeed (and do nothing) if told to
>>> insert a module which is already present or to remove a module which
>>> isn't present.
>>
>> This is not a case of already inserted module, it is not loaded before
>> the call to modprobe. It is the module_init callback
>> nf_conntrack_ftp_init() which returns -EEXIST it received from
>> nf_conntrack_helpers_register().

is this a real failure condition or something benign like "if it's
already registered, there's nothing to do"?

>>
>> Can't user space distinguish the two causes of -EEXIST? Or in other
>> words, is use of -EEXIST in module_init callbacks problematic?
>
>Unfortunately, error return codes from (f)init_module cannot be reliably
>depended upon. For instance, cpufreq drivers have similar behavior of
>returning -EEXIST when another cpufreq driver is already registered.
>Returning this code unexpectedly can then confuse kmod, as it interprets
>-EEXIST to mean "the module is already loaded" [1].

well, it's not that it can't be relied on. There's 1 exit code that is
treated specially, EEXISTS, because that error is used by the module
loading part, before the module_init call, to signify the module is
already loaded.

>
>I have thought about this problem before. We might fix the main
>problematic occurrences, but we can't really audit all the code that
>module init functions can invoke. I then wonder if it would make sense
>for the module loader to warn about any -EEXIST returned by a module's
>init function and translate it to -EBUSY.

If it's a failure condition then yes, -EBUSY looks appropriate.

Lucas De Marchi

>
>Ensuring the reliability of the 0 and -EEXIST return codes from
>(f)init_module should help user space.
>
>[1] https://github.com/kmod-project/kmod/blob/695fd084a727cf76f51b129b67d5a4be1d6db32e/libkmod/libkmod-module.c#L1087
>
>-- Petr
