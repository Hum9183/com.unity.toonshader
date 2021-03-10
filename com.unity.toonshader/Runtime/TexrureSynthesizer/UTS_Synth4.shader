﻿
Shader "Hidden/UnityToonShader/Synth4" {
	Properties{
		Source0("Source0 (R)", 2D) = "clear" {}
		Source1("Source1 (G)", 2D) = "clear" {}
		Source2("Source2 (B)", 2D) = "clear" {}
		Source3("Source3 (A)", 2D) = "clear" {}
		[KeywordEnum(None, Front, Back)] _Cull("Culling", Int) = 2
	}



	SubShader{
		Tags {"Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent"}
		LOD 100
		Cull Off
		ZTest Off
		ZWrite Off
		Blend one   zero
		//		ColorMask RGB
		//Blend SrcColor DstColor, SrcAlpha OneMinusSrcAlpha
		//    RGB                        ALPHA
		//			Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma multi_compile_fog

			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f {
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D Source0;
			sampler2D Source1;
			sampler2D Source2;
			sampler2D Source3;
			float4 Source0_ST;
			float4 Source1_ST;
			float4 Source2_ST;
			float4 Source3_ST;


			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, Source0);
				return o;
			}



			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(Source0, i.uv);
				col.g = tex2D(Source1, i.uv).r;
				col.b = tex2D(Source1, i.uv).r;
				col.a = tex2D(Source1, i.uv).r;

				return col;
			}
			ENDCG
		}
	}


}
