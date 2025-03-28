Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazolkn19012061.outbound.protection.outlook.com [52.103.33.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20F18E25
	for <linux-modules@vger.kernel.org>; Fri, 28 Mar 2025 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161791; cv=fail; b=dok5tcyh1yXzlrj6fHkTMriiAlH5tdimmErLve04UAHzitz1Ss5sz5NZHN+QM3KHL5hvqJEU2mZTERsSA+MdCP8Rawg4XEsobPAThmJb2CfSIPOrxsW9TqX77wdAJPi+hx2pcSH8RNf0QyvabfWqMhxMWIE49G18upGc/OHSBW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161791; c=relaxed/simple;
	bh=653qOyXECyOnn+56vP6ScM3PYQ+flCHrOjUkzeLZa+s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kl5Felp8dRjUZ6MkdOZaDPRLhkhSoYTANS0ZhZRosg+/usm8FLqyZKXHJOPdt5d6cAvnBcNM1Q6JTzfx7i70TIsfrqDjeL0xSrzc1JbNpvvZ+0q16DsSNmoAtKCwgTSiYsQ8ciliUD7k1QlhkHqTqXwVzjrhM63Nge6BJv+NCHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.fr; spf=pass smtp.mailfrom=live.fr; dkim=pass (2048-bit key) header.d=LIVE.FR header.i=@LIVE.FR header.b=pyi+PGzW; arc=fail smtp.client-ip=52.103.33.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.FR header.i=@LIVE.FR header.b="pyi+PGzW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knaFTDWWMYykjIy+/78/fkDjD5xP8mYfiCzqqYOUd6kjthZepIMBVFj2dcRen0ozWd/nQChCOrMlKk64/74sJgt5guk91BHxX8NY0HUZ7JL3qcFBCFypD59J7mWx2bKgoMPFhZJ2hx3e2fDpc8HB1iHlx7mc58Ov/3zJbXqFV2fxi4Q47RVti2cDFBwR7eLEaZstDFYTkUYT/zF3ZamJDXM9E7uWk8pFDEndYqTXRClDt0BftY6dsulHCuX6T2dJBZVhqh3MFRVmAdRdvNJeyQ5D1/1gGnWqql3K0VfTuF1Pq1xjxMeoyPwNqfCycMwA0AUnerbDK7RndfH4V/9QOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACZlGAl+jEAtljxznhdxi++ETkrODUBkQ1et7l6Crvo=;
 b=M5OxA6s0EAzPDpfGLwxGG266tuyDbpXCfnmrnAn2ODvfbVnUQ+g29IcOgc6rEstU7bYfRYZShyka9S9amsvwXCrb2iBGVq1boqeeYu5jmZy+mXsg0e/ib7xQiIeRb8/USZHA0mdbsHCiqXiSAAluo2pclQqZK+xkYvEEpYidJzGIJrwVmLgOqWPlafjqmxGjrzsn2EtyngEKh/y+ddAadCtvZIMzpyjMs1xj3zpAecn34ETFkdkpt+KMiOyEa+f6ueq3tv4TY/iKPn7X5p6RuFollxXy8LMIjupagkAdsAum1dh3HZ3n3t8xaFgJEEdRhB8wf3iLKpVlvf0GDLbLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.FR; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACZlGAl+jEAtljxznhdxi++ETkrODUBkQ1et7l6Crvo=;
 b=pyi+PGzWcmxFhmB9g9esGHGjefiMAdO+ddT0IPTr+HvpOPpkkmOg8vLyeUdjeAGCboul2jfws9uGI5N1K2SvAO4GzJwqbtLb8rLfoVM9usVHWAPA0BCHvh98IpOyxHpwzBuEvIWKqnSNf91uGDzaMIFa8fmHSxc2nQIBX4bXrTExjCu57UXcB+xp+lWZq4ntcrpIEnxGRuHnlEFKbYpNPyIz/i/9nSGxjzgtb9uIdchzA6o5S/uZjP56SZgKQHIjFQp0LgHp7hzDjpepedbrpecWe/PnNki05yNsBqiJ3pGCQXSmkr7PGzt5fIQ9wwauvR/KWLgBIW94FjMw1YShXg==
Received: from PR1PR02MB4826.eurprd02.prod.outlook.com (2603:10a6:102:f::27)
 by VI1PR02MB6016.eurprd02.prod.outlook.com (2603:10a6:800:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 11:36:27 +0000
Received: from PR1PR02MB4826.eurprd02.prod.outlook.com
 ([fe80::cc93:c9dd:83e2:8fd6]) by PR1PR02MB4826.eurprd02.prod.outlook.com
 ([fe80::cc93:c9dd:83e2:8fd6%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 11:36:27 +0000
Message-ID:
 <PR1PR02MB482622FAC838EFA69D566F549BA02@PR1PR02MB4826.eurprd02.prod.outlook.com>
Subject: Re: [PATCH kmod] tools/rmmod: fix garbled error message
From: Yannick Le Pennec <yannick.lepennec@live.fr>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Date: Fri, 28 Mar 2025 12:36:25 +0100
In-Reply-To: <igg6ghsjjn7ciboakccpavw3vbjssk23mhab5nbe7qpaqap7kk@6btizzrn26y3>
References:
 <VI1PR02MB48291E3BDB7E764ED67154949BA42@VI1PR02MB4829.eurprd02.prod.outlook.com>
	 <igg6ghsjjn7ciboakccpavw3vbjssk23mhab5nbe7qpaqap7kk@6btizzrn26y3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
X-ClientProxiedBy: PR0P264CA0209.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::29) To PR1PR02MB4826.eurprd02.prod.outlook.com
 (2603:10a6:102:f::27)
X-Microsoft-Original-Message-ID:
 <57c0e6a271d409ff86c597735b61971e306ce889.camel@live.fr>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR1PR02MB4826:EE_|VI1PR02MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea26288-c6d8-40bf-6380-08dd6decc681
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|5072599009|8060799006|6090799003|19110799003|461199028|10035399004|3412199025|4302099013|440099028|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjlNOWh0d3Ixai9aZSt2czRGSmFDSmFBd2F0WFpkNGh3cDdzSytIdVJkYUR6?=
 =?utf-8?B?K0lxd3ZGRStQVTIvTndEaWp4WDc0VGRsSWFBMjJLcVVId1dFbjQrSWhYcmNx?=
 =?utf-8?B?eG1yOWhPZmxSbjNEa2FJTG9QeW1HeE84N0tWaHh4TmkzKzlWM2x5NWdhL0w0?=
 =?utf-8?B?R2dpYkNTbkJydW1LUG5mRkx5ZXJPZWtLZmdyRWoySlpqUlBwd0lhZ01oUTBv?=
 =?utf-8?B?TFpxcHR1TFVrVjk4T1BhU1V2STJyWkx6eFFOVTMrNVF0MllCYzlObEt0S3ph?=
 =?utf-8?B?eFlvaERjT0hZQk92NzNYNG1jalFPOHhnTEtFc1UweU4vdk5kMmJvdlI0WnVY?=
 =?utf-8?B?bExMeStkT1kySFNsNmRuR1YzdExja2xTYm4yMmQ0STgvVGhrNkxhRHRFd0JX?=
 =?utf-8?B?cXdMNHpzOGREQmhPYm9ZMXRCcGV4cW9YK0c3M1k2MGtvb2wyYmdpRy9ZZElO?=
 =?utf-8?B?MGx2SC9sN0kzVzBpSFFzQmIwa1RpTUVadzE0YS92T0hrT1B6dE80bVpnelpQ?=
 =?utf-8?B?ZEdkdWd5WHkzRnkrY1d0UzRoRG9uSER2NHNWR0JVSS9VclZCb2Y4dCt6a1FL?=
 =?utf-8?B?Nlc2bGRHMWE0ZlBockpuMVgwSmtWYy8xaCtrRlZYSUE5RHRzVStDYU1CdGVI?=
 =?utf-8?B?QXFIcktKdGE1MEJKYk5OUmF5TVFPZVZqQ3pWbFI2b2NOcEh4T3lsTHYxcFZV?=
 =?utf-8?B?bzJIOWprbkRqalRSWGZZaXNBRjNxVldVb3lJbWdXdDVobnVtczVKU0FURS9G?=
 =?utf-8?B?eS9CZEVyd1I3NkF5bzJLWFB1UmhKTnFNV3FxWEZwMk1FR0dNV1BCUnd4SjRu?=
 =?utf-8?B?RjVIL2t5ZkYvYnhoOHhIK2xYSldpMTRuaUlwUGp6bUcxSk5IUHFMM3BpZ2lF?=
 =?utf-8?B?aFVZY1RyU3dlNjM0dm52OXBPc2ZqSUFNOXU1cmRUSitpYXB4WXp1UVdZOFFq?=
 =?utf-8?B?Y2pWU3BJTG8wek93dmhUWWgvN3JCYWdyN3h3VTFvUVczN0VVYXhLRkd1ams1?=
 =?utf-8?B?aFp4allUVXdpVjdvbnlzalA2VlhxcnlLNmhZa3hTMHdVR20rTkJLZzREWjNv?=
 =?utf-8?B?djRGYUFxQlczS3A1bFBWQm9WQTlGY3B6QTFJcW5xVVJGWDI5eDc3c2RmN01G?=
 =?utf-8?B?UmZRU3lhS0tIM3dlL2FpdEpKcng1Ym9xS1hxY1prUDFTTzRFbUZBbEpraE1k?=
 =?utf-8?B?RDRocUp3WGpaWEpFaHc2Zmw1czZOdVowYVVxOTltSUxTWlZSRXJaamRNU3o3?=
 =?utf-8?B?M3BDYWtJdXM5TjVFRlhqNEVRMHB1elBvMFhHNjFlcWk4WWFMcmZnTWdvaEFZ?=
 =?utf-8?B?Y0RsZHpWTkhRZE0zUzAvYm5iTjlvZFh3NDRJL00yNzR4RktXcm9FcE9ZNWdw?=
 =?utf-8?B?YW9xSDZ1c3FDaHI0b25La0tzZVg0eVR6cndZSXJHd2VLenRmblVDMnduU2NU?=
 =?utf-8?B?eUQrT3RRNUVQWHNlaFpSYm00bFpxVEFGYXFqVS9GQldqdXhSTDA1Z0owWmZO?=
 =?utf-8?B?ZWlhT1J6OUtsL1loYkJrdzdNQnJUd0RkN2g5TTRSbUhmZEVUd0x2RnB4UElP?=
 =?utf-8?B?cE56WHgxS0lGWjdpMnZ2M3hKYXJybXF6eHJxRGZ0bFAzcDhNb3BxZjFnYlJK?=
 =?utf-8?B?c1Q0N08vcC91cWxKU29xT3V3aHdWRmp4U0Vld2tLdTJoUkdDWkpNMThycWVn?=
 =?utf-8?B?SU9JRFhQYXVhdGZta1ZpUm5FTGgrVkRzcE0xa0JNSzF3dWppdG9mRkFiRERo?=
 =?utf-8?B?cmhTY3dpVFF0QUROSEVhV09kMitKUndvdERHNExSWGwzZ05QbUd6MjlremNE?=
 =?utf-8?B?WE94eVJ1QTNNazFDOEJPUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGpRYmIrWUthRVdxanZtaWk5eDBLT2hLcVRTQ2ZOZ3c0YVRiTkFsTmIyMGJa?=
 =?utf-8?B?cGRyR3pueTZzYnV3Nmg5VmtKekxMUFpEeHg4S3JRYzhHT2prWk4yakljNFI3?=
 =?utf-8?B?N2pzcE9OTGNLMUYrY0s5N0pWTGpqR3czNngrdjljQzBFVkRjNUYzK0hubWdQ?=
 =?utf-8?B?QmhZbDQzSWtpUlF0WEo4VVFocHFDZVdBQkJBSkV4RjlyOGpGU2p4aVlNL0t5?=
 =?utf-8?B?SjVMZmxSekYvRGl5WGFNN0dVM2w3WTJYem1LVWFja3I2c1VmT1h2YWd3bzRw?=
 =?utf-8?B?OHIyWXJUOTlheVJIa21uT2JjNnBDRXBtR0Q4Z0d5MlJhL2RWRGMraXF6elRT?=
 =?utf-8?B?elh6c0VDRDNDVjhCNml0am1hVVFPUnY1Y21jcytweVBOdTdCR0lmZDVlSGFK?=
 =?utf-8?B?TWFTYTNzemk2WTlHclV5RmlhMkRxMUk0cFlETXFWV1NmeUlDREtZSFdzRm0y?=
 =?utf-8?B?NjcrRno0VzNlOXI4ejIzZFk3WjRiMHp3MFQ3WnBuOE5mWVdIN3Zia3owb25N?=
 =?utf-8?B?RUdMcVZINGwwR2w0a2wvT3owTFZSOWFuUTRxS0hIVTRhdlJnWG93K2Z4cVJN?=
 =?utf-8?B?Ty9tMWFJalBhbFpkSGFFbnFVNXlrNDBRR2J6ZTYweHR1VisrMHpybVN2YU54?=
 =?utf-8?B?Y01pUkVmNzVBaEFlNDlDRFNYRE45eE1HUXRjUUFHU2VCdEpMUGl5Q2hxMmxx?=
 =?utf-8?B?S3JpekxNSzVmQlI0V2NsNkh5NEZIMzNpcWovYnk3U2pMSHJJbEMvUEJ0ZDl0?=
 =?utf-8?B?YmxPYVR0c1ZLMjJUaGQ0ZGZ3S2dvR2ZKNWw5aVZlL2VFdXFrN1U0cVVXL1lL?=
 =?utf-8?B?M1IyVFpQU0QwbFQzM1YxdzlmZUJKYlJDR1BCbXJwNnZCVWJURGg0c2lrQUhM?=
 =?utf-8?B?WWNjd3o1ZUNpK21nRHN6QU5RVm5EU3J2bzhMLy8wQjFaaStEVEJNTU9LekhG?=
 =?utf-8?B?ZStLSVUwYmdDczBLeVUzQzRaTStlQmV6OHlEdTlCUHhldUd6V1F2MHdoMEpO?=
 =?utf-8?B?aHhpWVdtb1pHaEIwSm9YTjNqbEErcm5tNFBsY2lkY1h4TDlndG84TXEzR2lQ?=
 =?utf-8?B?Zlh0YTJvcHR1ZnJPNUYrT3N6ZHkzUjNBSkxPdXRPemZNTXA5ZHVUMzI4T1NL?=
 =?utf-8?B?M05RTVBFbENUR1psSGxibWNrQnJ4M1ROaFE2d2hNUmlFOGxmSVNrSzJ6bHN1?=
 =?utf-8?B?TmhTeG1EZ0RYN29vK1RldjhjS3VxMlhpb01yYkJ4MGgwT0pkU2xzeURjdVN6?=
 =?utf-8?B?eUZJd3ozaWVERWdhelJNaWFKNkJ4YmNIYm82SythTTVZWHY2Uyszc1Q3dWZh?=
 =?utf-8?B?YmRlK1IyL2dFK0ZhKzhNY1N5N3V3cE5GQnY0RnFpbmVRd3U3Rk13WlBpOUhB?=
 =?utf-8?B?SUt2WmFOV0E1SU5admFvMHg3dzZqSVpWV1pudnFUYTYwUmloZkFWbW9jTUx3?=
 =?utf-8?B?Q3QwdWxYME56WGlDeG5IbjJUY2F5ajdWV1dJaUUzeFM5eTllb1NFZTQ5MHl4?=
 =?utf-8?B?bksza1o3WFIrYTJKaitTYU9SVkNUOEhBQnl2dTNJWFVDK0d2cnVIVFZ1OTdS?=
 =?utf-8?B?U3pnaW9qcHowU2s0V2RzSmFheG9rNmVEUlh6emtNaGtBZmpQL1A5S1J5SC9P?=
 =?utf-8?B?RERYNVNMM3FvdkxyMEFxUG54aGd1amROcVR3UFgzZ25XTWVGRVUwa29PVXNr?=
 =?utf-8?B?Nk9oQXdSTjRvUUIzZzFySThseUZ5ZTJha0I3WEZLTmUzeDZnR2RoZGd2MVJw?=
 =?utf-8?Q?C6JJu0BpRcrpAnJKjYfCai8u3KqmMO3zJZhb7gI?=
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea26288-c6d8-40bf-6380-08dd6decc681
X-MS-Exchange-CrossTenant-AuthSource: PR1PR02MB4826.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 11:36:26.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6016

On Thu, 2025-03-27 at 23:13 -0500, Lucas De Marchi wrote:
> On Mon, Mar 24, 2025 at 06:35:53PM +0100, Yannick Le Pennec wrote:
> > a6f9cd0 ("tools/rmmod: consistently use ERR logging facility") fixed
> > the split between syslog and stderr of various error message substrings
> > by calling the ERR macro instead of writing directly to stderr, but in
> > doing so also completely mangled the output because the ERR macro
> > decorates its arguments:
> >=20
> >    $ rmmod iwlwifi
> >    rmmod: ERROR: Module iwlwifi is in use by:rmmod: ERROR:  iwlmvmrmmod=
: ERROR:
> >=20
> > And in syslog:
> >=20
> >    $ rmmod -s iwlwifi
> >    2025-03-24T17:22:34.878318+01:00 mangolassi rmmod: ERROR: Module iwl=
wifi is in use by:
> >    2025-03-24T17:22:34.889145+01:00 mangolassi rmmod: ERROR:  iwlmvm
> >    2025-03-24T17:22:34.889224+01:00 mangolassi rmmod: ERROR:
> >=20
> > This commit fixes that by building the holder names list with a strbuf
> > and then passes the whole thing at once to ERR.
>=20
> doesn't that mean the syslog version will only have 1 ERROR now?

Yes indeed but I think that's the right behaviour. Prior to a6f9cd0 there w=
as
only 1 error going to syslog (because the rest of the line was sent to stde=
rr
erroneously). With a6f9cd0 N + 2 (with N =3D number of holders) error lines=
 go to
syslog, which I don't think is what was intended? After all the stderr mess=
age
itself was always one line, and furthermore the lone ERR("\n") was odd.

>=20
> anyway, queued for CI at https://github.com/kmod-project/kmod/pull/328
>=20
> thanks
> Lucas De Marchi
>=20
> >=20
> > Fixes: a6f9cd0 ("tools/rmmod: consistently use ERR logging facility")
> > Signed-off-by: Yannick Le Pennec <yannick.lepennec@live.fr>
> > ---
> > tools/rmmod.c | 11 +++++++----
> > 1 file changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tools/rmmod.c b/tools/rmmod.c
> > index 962d850..61f2e00 100644
> > --- a/tools/rmmod.c
> > +++ b/tools/rmmod.c
> > @@ -15,6 +15,7 @@
> > #include <sys/types.h>
> >=20
> > #include <shared/macro.h>
> > +#include <shared/strbuf.h>
> >=20
> > #include <libkmod/libkmod.h>
> >=20
> > @@ -63,16 +64,18 @@ static int check_module_inuse(struct kmod_module *m=
od)
> >=20
> > 	holders =3D kmod_module_get_holders(mod);
> > 	if (holders !=3D NULL) {
> > +		DECLARE_STRBUF_WITH_STACK(buf, 128);
> > 		struct kmod_list *itr;
> >=20
> > -		ERR("Module %s is in use by:", kmod_module_get_name(mod));
> > -
> > 		kmod_list_foreach(itr, holders) {
> > 			struct kmod_module *hm =3D kmod_module_get_module(itr);
> > -			ERR(" %s", kmod_module_get_name(hm));
> > +			strbuf_pushchar(&buf, ' ');
> > +			strbuf_pushchars(&buf, kmod_module_get_name(hm));
> > 			kmod_module_unref(hm);
> > 		}
> > -		ERR("\n");
> > +
> > +		ERR("Module %s is in use by:%s\n", kmod_module_get_name(mod),
> > +		    strbuf_str(&buf));
> >=20
> > 		kmod_module_unref_list(holders);
> > 		return -EBUSY;
> > --=20
> > 2.49.0
